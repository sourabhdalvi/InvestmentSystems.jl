const INVESTMENT_SYSTEM_DESCRIPTOR_FILE = joinpath(
    dirname(pathof(InvestmentSystems)),
    "descriptors",
    "investment_system_inputs.json",
)

function System(
    data::PSY.PowerSystemTableData;
    forecast_resolution = nothing,
    time_series_in_memory = false,
    runchecks = true,
)
    sys = PSY.System(
        data.basepower;
        time_series_in_memory = time_series_in_memory,
        runchecks = runchecks,
    )
    #TODO: Node, Zone, Region
    PSY.loadzone_csv_parser!(sys, data)
    region_csv_parser!(sys, data)
    PSY.bus_csv_parser!(sys, data)
    PSY.load_csv_parser!(sys, data)

    # Services and forecasts must be last.
    parsers = (
        (PSY.get_dataframe(data, PSY.BRANCH::InputCategory), PSY.branch_csv_parser!),
        (PSY.get_dataframe(data, PSY.DC_BRANCH::InputCategory), PSY.dc_branch_csv_parser!),
        (PSY.get_dataframe(data, PSY.GENERATOR::InputCategory), gen_csv_parser!),
        (PSY.get_dataframe(data, PSY.RESERVE::InputCategory), PSY.services_csv_parser!),
    )

    for (val, parser) in parsers
        if !isnothing(val)
            parser(sys, data)
        end
    end

    if !isnothing(data.timeseries_metadata_file)
        PSY.add_forecasts!(
            sys,
            data.timeseries_metadata_file;
            resolution = forecast_resolution,
        )
    end

    PSY.check!(sys)
    return sys
end

"""
    loadzone_csv_parser!(sys::System, data::PowerSystemTableData)

Add branches to the System from the raw data.

"""
function region_csv_parser!(sys::PSY.System, data::PSY.PowerSystemTableData)
    buses = PSY.get_dataframe(data, PSY.BUS::InputCategory)
    region_column = PSY.get_user_field(data, PSY.BUS::InputCategory, "region")
    if !in(region_column, names(buses))
        @warn "Missing Data : no 'zone' information for buses, cannot create loads based on zones"
        return
    end

    regions = unique(buses[!, region_column])
    for region in regions
        bus_numbers = Set{Int}()
        active_powers = Vector{Float64}()
        reactive_powers = Vector{Float64}()
        for bus in PSY.iterate_rows(data, PSY.BUS::InputCategory)
            if bus.region == region
                bus_number = bus.bus_id
                push!(bus_numbers, bus_number)

                active_power = bus.max_active_power
                push!(active_powers, active_power)

                reactive_power = bus.max_reactive_power
                push!(reactive_powers, reactive_power)
            end
        end

        name = string(region)
        load_zone = PSY.LoadZone(name, sum(active_powers), sum(reactive_powers))
        region = Region(name, load_zone)
        PSY.add_component!(sys, region)
    end
end

"""
    gen_csv_parser!(sys::System, data::PowerSystemTableData)

Add generators to the System from the raw data.

"""
function gen_csv_parser!(sys::System, data::PSY.PowerSystemTableData)
    output_percent_fields = Vector{Symbol}()
    heat_rate_fields = Vector{Symbol}()
    fields = PSY.get_user_fields(data, PSY.GENERATOR::InputCategory)
    for field in fields
        if occursin("output_percent", field)
            push!(output_percent_fields, Symbol(field))
        elseif occursin("heat_rate_", field)
            push!(heat_rate_fields, Symbol(field))
        end
    end

    @assert length(output_percent_fields) > 0
    cost_colnames = zip(heat_rate_fields, output_percent_fields)

    for gen in PSY.iterate_rows(data, PSY.GENERATOR::InputCategory)
        bus = PSY.get_bus(sys, gen.bus_id)
        if isnothing(bus)
            throw(IS.DataFormatError("could not find $(gen.bus_id)"))
        end

        generator = make_generator(data, gen, cost_colnames, bus)
        if !isnothing(generator)
            PSY.add_component!(sys, generator)
        end
    end
end

"""Creates a generator of any type."""
function make_generator(data::PSY.PowerSystemTableData, gen, cost_colnames, bus)
    generator = nothing
    gen_type = PSY.get_generator_type(
        gen.fuel,
        get(gen, :unit_type, nothing),
        data.generator_mapping,
    )

    if gen_type == PSY.ThermalStandard
        generator = make_thermal_generator(data, gen, cost_colnames, bus)
    elseif gen_type <: PSY.HydroGen
        generator = make_hydro_generator(gen_type, data, gen, bus)
    elseif gen_type <: PSY.RenewableGen
        generator = make_renewable_generator(gen_type, data, gen, bus)
    elseif gen_type == PSY.GenericBattery
        generator = make_storage(data, gen, bus)
    else
        @error "Skipping unsupported generator" gen_type
    end

    return generator
end

function make_ext_thermal_generator(data::PSY.PowerSystemTableData, gen, cost_colnames, bus)

    available = true
    rating = sqrt(gen.active_power_limits_max^2 + gen.reactive_power_limits_max^2)
    capcaity_factor =
        CapacityFactor(gen.capacity_factor_average, gen.capacity_factor_marginal)
    outage_factor = Outage(gen.forced_outage, gen.planned_outage)
    heat_rate = HeatRate(;average = float(gen.heat_rate_incr_1), startup = gen.startup_heat_cold_cost)
    ## These are much harder to build from the CSV format
    emission = Emission[]
    service_operations =ServiceOperations[]
    alternate_fuel = nothing
    fuel_price = FuelPrice(convert(ThermalFuels.ThermalFuel, gen.fuel), gen.fuel_price)

    op = ThermalOperations(
                    capcaity_factor = capcaity_factor,
                    outage_factor = outage_factor,
                    heatrate = heat_rate,
                    minimum_load_factor = 0.0,
                    emission = Emission[],
                    service_operations = ServiceOperations[],
                    alternate_fuel = alternate_fuel,
                    fuel_price = fuel_price,
                )

    lifecycle = LifeCycle(
        lifetime = gen.life_time,
        build_year = gen.build_year,
        project_phase = convert(ProjectPhases.ProjectPhase, gen.project_phase),
        available = (after = gen.build_year, before = 2999), ## How do we get this ?
        construction = nothing,
        queue_time = nothing,
    )
    project_cost = ProjectCost(
        capital_cost = CapitalCost(gen.capital_cost),
        tax_rate = gen.tax_rate,
        discount_rate = gen.discount_rate,
        inflation_rate = gen.inflation_rate,
    )
    fin = GenericFinance(life_cycle = lifecycle, project_cost = project_cost)

    return Investment(op, fin) ## need to figure out retirement
end

function make_thermal_generator(data::PSY.PowerSystemTableData, gen, cost_colnames, bus)
    fuel_cost = gen.fuel_price / 1000

    var_cost = [(getfield(gen, hr), getfield(gen, mw)) for (hr, mw) in cost_colnames]
    var_cost = [
        (tryparse(Float64, string(c[1])), tryparse(Float64, string(c[2])))
        for c in var_cost if !in(nothing, c)
    ]
    if length(unique(var_cost)) > 1
        var_cost[2:end] = [
            (
                var_cost[i][1] *
                (var_cost[i][2] - var_cost[i - 1][2]) *
                fuel_cost *
                data.basepower,
                var_cost[i][2],
            ) .* gen.active_power_limits_max for i in 2:length(var_cost)
        ]
        var_cost[1] =
            (
                var_cost[1][1] * var_cost[1][2] * fuel_cost * data.basepower,
                var_cost[1][2],
            ) .* gen.active_power_limits_max

        fixed = max(
            0.0,
            var_cost[1][1] -
            (var_cost[2][1] / (var_cost[2][2] - var_cost[1][2]) * var_cost[1][2]),
        )
        var_cost[1] = (var_cost[1][1] - fixed, var_cost[1][2])
        for i in 2:length(var_cost)
            var_cost[i] = (var_cost[i - 1][1] + var_cost[i][1], var_cost[i][2])
        end
    else
        var_cost = [(0.0, var_cost[1][2]), (1.0, var_cost[1][2])]
        fixed = 0.0
    end
    status = true
    available = true
    rating = sqrt(gen.active_power_limits_max^2 + gen.reactive_power_limits_max^2)
    active_power_limits =
        (min = gen.active_power_limits_min, max = gen.active_power_limits_max)
    reactive_power_limits =
        (min = gen.reactive_power_limits_min, max = gen.reactive_power_limits_max)
    ramp = get(gen, :ramp_limits, nothing)
    min_up_time = get(gen, :min_up_time, nothing)
    min_down_time = get(gen, :min_down_time, nothing)
    timelimits = isnothing(min_up_time) && isnothing(min_down_time) ? nothing :
        (up = min_up_time, down = min_down_time)
    rating = rating
    primemover = convert(PrimeMovers.PrimeMover, gen.unit_type)
    fuel = convert(ThermalFuels.ThermalFuel, gen.fuel)
    activepowerlimits = active_power_limits
    reactivepowerlimits = reactive_power_limits
    ramplimits = isnothing(ramp) ? ramp : (up = ramp, down = ramp)
    timelimits = timelimits
    capacity = gen.active_power_limits_max
    startup_cost = get(gen, :startup_cost, nothing)
    if isnothing(startup_cost)
        if hasfield(typeof(gen), :startup_heat_cold_cost)
            startup_cost = gen.startup_heat_cold_cost * fuel_cost * 1000
        else
            startup_cost = 0.0
            @warn "No startup_cost defined for $(gen.name), setting to $startup_cost" maxlog =
                5
        end
    end

    shutdown_cost = get(gen, :shutdown_cost, nothing)
    if isnothing(shutdown_cost)
        @warn "No shutdown_cost defined for $(gen.name), setting to 0.0" maxlog = 1
        shutdown_cost = 0.0
    end
    op_cost = PSY.ThreePartCost(var_cost, fixed, startup_cost, shutdown_cost)

    ext = Dict{String, Any}()
    ext["Investment"] = make_ext_thermal_generator(data, gen, cost_colnames, bus)

    return PSY.ThermalStandard(
        gen.name,
        available,
        status,
        bus,
        gen.active_power,
        gen.reactive_power,
        rating,
        primemover,
        fuel,
        active_power_limits,
        reactive_power_limits,
        ramplimits,
        timelimits,
        op_cost,
        PSY.Device[],
        0.0,
        ext
    )
end

function make_ext_hydro_generator(gen_type, data::PSY.PowerSystemTableData, gen, bus)

    capcaity_factor =
        CapacityFactor(gen.capacity_factor_average, gen.capacity_factor_marginal)
    outage_factor = Outage(gen.forced_outage, gen.planned_outage)
    curtailment = Curtailment(gen.curtailment_average, gen.curtailment_marginal)

    op = HydroOperations(
        capcaity_factor = capcaity_factor,
        outage_factor = outage_factor,
        curtailment = curtailment,
        minimum_load_factor = 0.0,
        service_operations = ServiceOperations[],
    )

    lifecycle = LifeCycle(
        lifetime = gen.life_time,
        build_year = gen.build_year,
        project_phase = convert(ProjectPhases.ProjectPhase, gen.project_phase),
        available = (after = gen.build_year, before = 2999), ## How do we get this ?
        construction = nothing,
        queue_time = nothing,
    )
    project_cost = ProjectCost(
        capital_cost = CapitalCost(gen.capital_cost),
        tax_rate = gen.tax_rate,
        discount_rate = gen.discount_rate,
        inflation_rate = gen.inflation_rate,
    )
    capcaity_credit =
        CapacityCredit(gen.capacity_credit_average, gen.capacity_credit_marginal)
    fin = HydroFinance(
        capcaity_credit = capcaity_credit,
        life_cycle = lifecycle,
        incentive = 0.0,
        project_cost = project_cost,
    )

    return Investment(op, fin)
end



function make_hydro_generator(gen_type, data::PSY.PowerSystemTableData, gen, bus)
    available = true
    rating = PSY.calculate_rating(gen.active_power_limits_max, gen.reactive_power_limits_max)
    active_power_limits =
        (min = gen.active_power_limits_min, max = gen.active_power_limits_max)
    reactive_power_limits =
        (min = gen.reactive_power_limits_min, max = gen.reactive_power_limits_max)
    ramp = get(gen, :ramp_limits, nothing)
    min_up_time = get(gen, :min_up_time, nothing)
    min_down_time = get(gen, :min_down_time, nothing)
    timelimits = isnothing(min_up_time) && isnothing(min_down_time) ? nothing :
        (up = min_up_time, down = min_down_time)

    ext = Dict{String, Any}()
    ext["Investment"] = make_ext_hydro_generator(gen_type, data, gen, bus)

    if gen_type == PSY.HydroEnergyReservoir
        if !haskey(data.category_to_df, PSY.STORAGE)
            throw(IS.DataFormatError("Storage information must defined in storage.csv"))
        end
        @debug("Creating $(gen.name) as HydroEnergyReservoir")
        storage = PSY.get_storage_by_generator(data, gen.name)
        curtailcost = 0.0
        hydro_gen = PSY.HydroEnergyReservoir(
            name = gen.name,
            available = available,
            bus = bus,
            activepower = gen.active_power,
            reactivepower = gen.reactive_power,
            primemover = convert(PrimeMovers.PrimeMover, gen.unit_type),
            rating = rating,
            activepowerlimits = active_power_limits,
            reactivepowerlimits = reactive_power_limits,
            ramplimits = isnothing(ramp) ? ramp : (up = ramp, down = ramp),
            timelimits = timelimits,
            op_cost = PSY.TwoPartCost(curtailcost, 0.0),
            storage_capacity = storage.storage_capacity,
            inflow = storage.inflow_limit,
            initial_storage = storage.initial_storage,
            services = PSY.Device[],
            ext = ext
        )
    elseif gen_type == PSY.HydroDispatch
        @debug("Creating $(gen.name) as HydroDispatch")
        hydro_gen = PSY.HydroDispatch(
            name = gen.name,
            available = available,
            bus = bus,
            activepower = gen.active_power,
            reactivepower = gen.reactive_power,
            rating = rating,
            primemover = convert(PrimeMovers.PrimeMover, gen.unit_type),
            activepowerlimits = active_power_limits,
            reactivepowerlimits = reactive_power_limits,
            ramplimits = isnothing(ramp) ? ramp : (up = ramp, down = ramp),
            timelimits = timelimits,
            services = PSY.Device[],
            ext = ext
        )
    else
        error("Tabular data parser does not currently support $gen_type creation")
    end
    return hydro_gen
end

function make_ext_renewable_generator(gen_type, data::PSY.PowerSystemTableData, gen, bus)

    capcaity_factor =
        CapacityFactor(gen.capacity_factor_average, gen.capacity_factor_marginal)
    outage_factor = Outage(gen.forced_outage, gen.planned_outage)
    curtailment = Curtailment(gen.curtailment_average, gen.curtailment_marginal)

    op = RenewableOperations(
        capcaity_factor = capcaity_factor,
        outage_factor = outage_factor,
        curtailment = curtailment,
        minimum_load_factor = 0.0,
        growth_rate = gen.growth_rate,
        service_operations = ServiceOperations[],
    )

    lifecycle = LifeCycle(
        lifetime = gen.life_time,
        build_year = gen.build_year,
        project_phase = convert(ProjectPhases.ProjectPhase, gen.project_phase),
        available = (after = gen.build_year, before = 2999), ## How do we get this ?
        construction = nothing,
        queue_time = nothing,
    )
    project_cost = ProjectCost(
        capital_cost = CapitalCost(gen.capital_cost),
        tax_rate = gen.tax_rate,
        discount_rate = gen.discount_rate,
        inflation_rate = gen.inflation_rate,
    )
    capacity_credit =
        CapacityCredit(gen.capacity_credit_average, gen.capacity_credit_marginal)
    fin = RenewableFinance(
        capacity_credit = capacity_credit,
        life_cycle = lifecycle,
        incentive = 0.0,
        project_cost = project_cost,
    )
    return Investment(op, fin)
end

function make_renewable_generator(gen_type, data::PSY.PowerSystemTableData, gen, bus)
    generator = nothing
    available = true
    rating = gen.active_power_limits_max
    ext = Dict{String, Any}()
    ext["Investment"] = make_ext_renewable_generator(gen_type, data, gen, bus)

    if gen_type == PSY.RenewableDispatch
        generator = PSY.RenewableDispatch(
            gen.name,
            available,
            bus,
            gen.active_power,
            gen.reactive_power,
            rating,
            convert(PrimeMovers.PrimeMover, gen.unit_type),
            (min = gen.reactive_power_limits_min, max = gen.reactive_power_limits_max),
            1.0,
            PSY.TwoPartCost(0.0, 0.0),
            PSY.Device[],
            ext
        )
    elseif gen_type == PSY.RenewableFix
        generator = PSY.RenewableFix(
            gen.name,
            available,
            bus,
            gen.active_power,
            gen.reactive_power,
            rating,
            convert(PrimeMovers.PrimeMover, gen.unit_type),
            1.0,
            PSY.Device[],
            ext
        )
    else
        error("Unsupported type $gen_type")
    end

    return generator
end


function make_ext_storage(data::PSY.PowerSystemTableData, gen, bus)

    capcaity_factor =
        CapacityFactor(gen.capacity_factor_average, gen.capacity_factor_marginal)
    outage_factor = Outage(gen.forced_outage, gen.planned_outage)
    curtailment = Curtailment(gen.curtailment_average, gen.curtailment_marginal)

    battery = BatteryOperations(
        capcaity_factor = capcaity_factor,
        outage_factor = outage_factor,
        duration = gen.duration,
        curtailment_reduction = gen.curtailment_reduction,
        service_operations = ServiceOperations[],
    )
    lifecycle = LifeCycle(
        lifetime = gen.life_time,
        build_year = gen.build_year,
        project_phase = convert(ProjectPhases.ProjectPhase, gen.project_phase),
        available = (after = gen.build_year, before = 2999), ## How do we get this ?
        construction = nothing,
        queue_time = nothing,
    )
    project_cost = ProjectCost(
        capital_cost = CapitalCost(gen.capital_cost),
        tax_rate = gen.tax_rate,
        discount_rate = gen.discount_rate,
        inflation_rate = gen.inflation_rate,
    )
    capcaity_credit =
        CapacityCredit(gen.capacity_credit_average, gen.capacity_credit_marginal)

    fin = BatteryFinance(
        capcaity_credit = capcaity_credit,
        life_cycle = lifecycle,
        incentive = 0.0,
        project_cost = project_cost,
    )
    return Investment(battery, fin)
end

function make_storage(data::PSY.PowerSystemTableData, gen, bus)
    available = true
    energy = 0.0
    capacity = (min = gen.active_power_limits_min, max = gen.active_power_limits_max)
    rating = gen.active_power_limits_max
    input_active_power_limits = (min = 0.0, max = gen.active_power_limits_max)
    output_active_power_limits = (min = 0.0, max = gen.active_power_limits_max)
    efficiency = (in = 0.9, out = 0.9)
    reactive_power_limits = (min = 0.0, max = 0.0)
    ext = Dict{String, Any}()
    ext["Investment"] = make_ext_storage(data, gen, bus)

    battery = PSY.GenericBattery(
        name = gen.name,
        available = available,
        bus = bus,
        primemover = convert(PrimeMovers.PrimeMover, gen.unit_type),
        energy = energy,
        capacity = capacity,
        rating = rating,
        activepower = gen.active_power,
        inputactivepowerlimits = input_active_power_limits,
        outputactivepowerlimits = output_active_power_limits,
        efficiency = efficiency,
        reactivepower = gen.reactive_power,
        reactivepowerlimits = reactive_power_limits,
        services = PSY.Device[],
        ext = ext
    )

    return battery
end