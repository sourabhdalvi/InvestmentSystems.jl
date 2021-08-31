#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct ThermalOperations <: AbstractOperations
        capcaity_factor::CapacityFactor
        outage_factor::Outage
        heatrate::HeatRate
        minimum_load_factor::Float64
        emission::Vector{Emission}
        service_operations::Vector{ServiceOperations}
        alternate_fuel::Union{Nothing, AlternateFuel}
        fuel_price::Union{Nothing, FuelPrice}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_factor::CapacityFactor`
- `outage_factor::Outage`
- `heatrate::HeatRate`: heatrates from ReEDS
- `minimum_load_factor::Float64`: minloadfrac from ReEDS, validation range: (0, nothing), action if invalid: warn
- `emission::Vector{Emission}`: emit_rate from ReEDS
- `service_operations::Vector{ServiceOperations}`
- `alternate_fuel::Union{Nothing, AlternateFuel}`: bio_cofire_perc from ReEDS
- `fuel_price::Union{Nothing, FuelPrice}`: fuel_price from ReEDS
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct ThermalOperations <: AbstractOperations
    capcaity_factor::CapacityFactor
    outage_factor::Outage
    "heatrates from ReEDS"
    heatrate::HeatRate
    "minloadfrac from ReEDS"
    minimum_load_factor::Float64
    "emit_rate from ReEDS"
    emission::Vector{Emission}
    service_operations::Vector{ServiceOperations}
    "bio_cofire_perc from ReEDS"
    alternate_fuel::Union{Nothing, AlternateFuel}
    "fuel_price from ReEDS"
    fuel_price::Union{Nothing, FuelPrice}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function ThermalOperations(
    capcaity_factor,
    outage_factor,
    heatrate,
    minimum_load_factor,
    emission = Emission[],
    service_operations = ServiceOperations[],
    alternate_fuel = nothing,
    fuel_price = nothing,
)
    ThermalOperations(
        capcaity_factor,
        outage_factor,
        heatrate,
        minimum_load_factor,
        emission,
        service_operations,
        alternate_fuel,
        fuel_price,
        InfrastructureSystemsInternal(),
    )
end

function ThermalOperations(;
    capcaity_factor,
    outage_factor,
    heatrate,
    minimum_load_factor,
    emission = Emission[],
    service_operations = ServiceOperations[],
    alternate_fuel = nothing,
    fuel_price = nothing,
)
    ThermalOperations(
        capcaity_factor,
        outage_factor,
        heatrate,
        minimum_load_factor,
        emission,
        service_operations,
        alternate_fuel,
        fuel_price,
    )
end

# Constructor for demo purposes; non-functional.
function ThermalOperations(::Nothing)
    ThermalOperations(;
        capcaity_factor = CapacityFactor(nothing),
        outage_factor = Outage(nothing),
        heatrate = HeatRate(nothing),
        minimum_load_factor = 0.0,
        emission = Emission[],
        service_operations = ServiceOperations[],
        alternate_fuel = nothing,
        fuel_price = nothing,
    )
end

"""Get ThermalOperations capcaity_factor."""
get_capcaity_factor(value::ThermalOperations) = value.capcaity_factor
"""Get ThermalOperations outage_factor."""
get_outage_factor(value::ThermalOperations) = value.outage_factor
"""Get ThermalOperations heatrate."""
get_heatrate(value::ThermalOperations) = value.heatrate
"""Get ThermalOperations minimum_load_factor."""
get_minimum_load_factor(value::ThermalOperations) = value.minimum_load_factor
"""Get ThermalOperations emission."""
get_emission(value::ThermalOperations) = value.emission
"""Get ThermalOperations service_operations."""
get_service_operations(value::ThermalOperations) = value.service_operations
"""Get ThermalOperations alternate_fuel."""
get_alternate_fuel(value::ThermalOperations) = value.alternate_fuel
"""Get ThermalOperations fuel_price."""
get_fuel_price(value::ThermalOperations) = value.fuel_price
"""Get ThermalOperations internal."""
get_internal(value::ThermalOperations) = value.internal
