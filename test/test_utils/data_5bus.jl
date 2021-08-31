using TimeSeries
using Dates
using Random
using PowerSystems
using InvestmentSystems

DayAhead = collect(
    DateTime("1/1/2024  0:00:00", "d/m/y  H:M:S"):Hour(1):DateTime(
        "1/1/2024  23:00:00",
        "d/m/y  H:M:S",
    ),
)

buses5() = [
    Bus(1, "nodeA", "PV", 0, 1.0, (min = 0.9, max = 1.05), 230),
    Bus(2, "nodeB", "PQ", 0, 1.0, (min = 0.9, max = 1.05), 230),
    Bus(3, "nodeC", "PV", 0, 1.0, (min = 0.9, max = 1.05), 230),
    Bus(4, "nodeD", "REF", 0, 1.0, (min = 0.9, max = 1.05), 230),
    Bus(5, "nodeE", "PV", 0, 1.0, (min = 0.9, max = 1.05), 230),
];

loadzone_node5(buses5) = [
    LoadZone("1", "rl1", buses5[1:2], 1.3, 0.9),
    LoadZone("2", "rl2", buses5[3], 1.4, 0.8),
    LoadZone("3", "rl3", buses5[4:5], 1.2, 1.1),
];

loadzone_zone5(buses5) = [
    LoadZone("1", "ba1", buses5[1:3], 1.3, 0.9),
    LoadZone("2", "ba2", buses5[4:5], 1.4, 0.8),
];

loadzone_region5(buses5) = [LoadZone("1", "st1", buses5, 1.3, 0.9)];

emitpol5 = [
    EmissionPolicy(InvestmentSystems.CO2, 100.0, 500.0),
    EmissionPolicy(InvestmentSystems.SO2, 100.0, 50.0),
];

nodes5(loadzone_node5) =
    [Node(loadzone_node5[1]), Node(loadzone_node5[2]), Node(loadzone_node5[3])];

zones5(loadzone_zone5) =
    [Zone(loadzone_zone5[1], 0.25, 1.5), Zone(loadzone_zone5[2], 0.2, 0.98)];

region5(loadzone_region5) = [Region(loadzone_region5)];

branches5(nodes5) = [
    Line(
        "1",
        true,
        0.0,
        0.0,
        Arc(from = nodes5[1], to = nodes5[2]),
        0.00281,
        0.0281,
        (from = 0.00356, to = 0.00356),
        2.0,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "2",
        true,
        0.0,
        0.0,
        Arc(from = nodes5[1], to = nodes5[4]),
        0.00304,
        0.0304,
        (from = 0.00329, to = 0.00329),
        2.0,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "3",
        true,
        0.0,
        0.0,
        Arc(from = nodes5[1], to = nodes5[5]),
        0.00064,
        0.0064,
        (from = 0.01563, to = 0.01563),
        18.8120,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "4",
        true,
        0.0,
        0.0,
        Arc(from = nodes5[2], to = nodes5[3]),
        0.00108,
        0.0108,
        (from = 0.00926, to = 0.00926),
        11.1480,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "5",
        true,
        0.0,
        0.0,
        Arc(from = nodes5[3], to = nodes5[4]),
        0.00297,
        0.0297,
        (from = 0.00337, to = 0.00337),
        40.530,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "6",
        true,
        0.0,
        0.0,
        Arc(from = nodes5[4], to = nodes5[5]),
        0.00297,
        0.0297,
        (from = 0.00337, to = 00.00337),
        2.00,
        (min = -0.7, max = 0.7),
    ),
];

branches5_dc(buses5) = [
    Line(
        "1",
        true,
        0.0,
        0.0,
        Arc(from = buses5[1], to = buses5[2]),
        0.00281,
        0.0281,
        (from = 0.00356, to = 0.00356),
        2.0,
        (min = -0.7, max = 0.7),
    ),
    HVDCLine(
        "DCL2",
        true,
        0.0,
        Arc(from = buses5[1], to = buses5[4]),
        (min = -3000.0, max = 3000.0),
        (min = -3000, max = 3000),
        (min = -3000.0, max = 3000.0),
        (min = -3000.0, max = 3000.0),
        (l0 = 0.0, l1 = 0.01),
    ),
    Line(
        "3",
        true,
        0.0,
        0.0,
        Arc(from = buses5[1], to = buses5[5]),
        0.00064,
        0.0064,
        (from = 0.01563, to = 0.01563),
        18.8120,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "4",
        true,
        0.0,
        0.0,
        Arc(from = buses5[2], to = buses5[3]),
        0.00108,
        0.0108,
        (from = 0.00926, to = 0.00926),
        11.1480,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "5",
        true,
        0.0,
        0.0,
        Arc(from = buses5[3], to = buses5[4]),
        0.00297,
        0.0297,
        (from = 0.00337, to = 0.00337),
        40.530,
        (min = -0.7, max = 0.7),
    ),
    Line(
        "6",
        true,
        0.0,
        0.0,
        Arc(from = buses5[4], to = buses5[5]),
        0.00297,
        0.0297,
        (from = 0.00337, to = 00.00337),
        2.00,
        (min = -0.7, max = 0.7),
    ),
];

solar_ts_DA = [
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0.351105684
    0.632536266
    0.99463925
    1
    0.944237283
    0.396681234
    0.366511428
    0.155125829
    0.040872694
    0
    0
    0
    0
    0
    0
]

wind_ts_DA = [
    0.985205412
    0.991791369
    0.997654144
    1
    0.998663733
    0.995497149
    0.992414567
    0.98252418
    0.957203427
    0.927650911
    0.907181989
    0.889095913
    0.848186718
    0.766813846
    0.654052531
    0.525336131
    0.396098004
    0.281771509
    0.197790004
    0.153241012
    0.131355854
    0.113688144
    0.099302656
    0.069569628
]

investment_thermal5 = [
    Investment(
        ThermalOperations(
            CapacityFactor(0.8, 0.75),
            Outage(nothing),
            HeatRate(100.0, 50.0),
            0.0,
        ),
        GenericFinance(LifeCycle(nothing)),
    ),
    Investment(
        ThermalOperations(
            CapacityFactor(0.6, 0.5),
            Outage(nothing),
            HeatRate(100.0, 50.0),
            0.0,
        ),
        GenericFinance(LifeCycle(nothing)),
    ),
    Investment(
        ThermalOperations(
            CapacityFactor(1.0, 1.0),
            Outage(nothing),
            HeatRate(100.0, 50.0),
            0.0,
        ),
        GenericFinance(LifeCycle(nothing)),
    ),
    Investment(
        ThermalOperations(
            CapacityFactor(0.7, 0.8),
            Outage(nothing),
            HeatRate(100.0, 50.0),
            0.0,
        ),
        GenericFinance(LifeCycle(nothing)),
    ),
    Investment(
        ThermalOperations(
            CapacityFactor(1.0, 1.0),
            Outage(nothing),
            HeatRate(100.0, 50.0),
            0.0,
        ),
        GenericFinance(LifeCycle(nothing)),
    ),
]

thermal_generators5(buses5) = [
    ThermalStandard(
        "Alta",
        true,
        buses5[1],
        0.40,
        0.010,
        TechThermal(
            0.5,
            PowerSystems.ST,
            PowerSystems.COAL,
            (min = 0.0, max = 0.40),
            (min = -0.30, max = 0.30),
            nothing,
            nothing,
        ),
        ThreePartCost((0.0, 1400.0), 0.0, 4.0, 2.0),
        Device[],
        Dict{String, Any}("Investment" => investment_thermal5[1]),
    ),
    ThermalStandard(
        "Park City",
        true,
        buses5[1],
        1.70,
        0.20,
        TechThermal(
            2.2125,
            PowerSystems.ST,
            PowerSystems.COAL,
            (min = 0.0, max = 1.70),
            (min = -1.275, max = 1.275),
            (up = 0.02, down = 0.02),
            (up = 2.0, down = 1.0),
        ),
        ThreePartCost((0.0, 1500.0), 0.0, 1.5, 0.75),
        Device[],
        Dict{String, Any}("Investment" => investment_thermal5[2]),
    ),
    ThermalStandard(
        "Solitude",
        true,
        buses5[3],
        5.2,
        1.00,
        TechThermal(
            5.20,
            PowerSystems.ST,
            PowerSystems.COAL,
            (min = 0.0, max = 5.20),
            (min = -3.90, max = 3.90),
            (up = 0.012, down = 0.012),
            (up = 3.0, down = 2.0),
        ),
        ThreePartCost((0.0, 3000.0), 0.0, 3.0, 1.5),
        Device[],
        Dict{String, Any}("Investment" => investment_thermal5[3]),
    ),
    ThermalStandard(
        "Sundance",
        true,
        buses5[4],
        2.0,
        0.40,
        TechThermal(
            2.5,
            PowerSystems.ST,
            PowerSystems.COAL,
            (min = 0.0, max = 2.0),
            (min = -1.5, max = 1.5),
            (up = 0.015, down = 0.015),
            (up = 2.0, down = 1.0),
        ),
        ThreePartCost((0.0, 4000.0), 0.0, 4.0, 2.0),
        Device[],
        Dict{String, Any}("Investment" => investment_thermal5[4]),
    ),
    ThermalStandard(
        "Brighton",
        true,
        buses5[5],
        6.0,
        1.50,
        TechThermal(
            7.5,
            PowerSystems.ST,
            PowerSystems.COAL,
            (min = 0.0, max = 6.0),
            (min = -4.50, max = 4.50),
            (up = 0.015, down = 0.015),
            (up = 5.0, down = 3.0),
        ),
        ThreePartCost((0.0, 1000.0), 0.0, 1.5, 0.75),
        Device[],
        Dict{String, Any}("Investment" => investment_thermal5[5]),
    ),
];

investment_renewable = [
    Investment(
        RenewableOperations(
            CapacityFactor(0.6, 0.5),
            Outage(nothing),
            Curtailment(nothing),
            0.0,
            0.0,
        ),
        RenewableFinance(CapacityCredit(10.0, 1.0), LifeCycle(nothing), 0.0),
    ),
    Investment(
        RenewableOperations(
            CapacityFactor(0.6, 0.5),
            Outage(nothing),
            Curtailment(nothing),
            0.0,
            0.0,
        ),
        RenewableFinance(CapacityCredit(10.0, 1.0), LifeCycle(nothing), 0.0),
    ),
    Investment(
        RenewableOperations(
            CapacityFactor(0.6, 0.5),
            Outage(nothing),
            Curtailment(nothing),
            0.0,
            0.0,
        ),
        RenewableFinance(CapacityCredit(10.0, 1.0), LifeCycle(nothing), 0.0),
    ),
];

renewable_generators5(buses5) = [
    RenewableDispatch(
        "WindBusA",
        true,
        buses5[5],
        0.0,
        0.0,
        TechRenewable(1.20, PowerSystems.WT, (min = -0.800, max = 0.800), 1.0),
        TwoPartCost(22.0, 0.0),
        Device[],
        Dict{String, Any}("Investment" => investment_renewable[1]),
    ),
    RenewableDispatch(
        "WindBusB",
        true,
        buses5[4],
        0.0,
        0.0,
        TechRenewable(1.20, PowerSystems.WT, (min = -0.800, max = 0.800), 1.0),
        TwoPartCost(22.0, 0.0),
        Device[],
        Dict{String, Any}("Investment" => investment_renewable[2]),
    ),
    RenewableDispatch(
        "WindBusC",
        true,
        buses5[3],
        0.0,
        0.0,
        TechRenewable(1.20, PowerSystems.WT, (min = -0.800, max = 0.800), 1.0),
        TwoPartCost(22.0, 0.0),
        Device[],
        Dict{String, Any}("Investment" => investment_renewable[3]),
    ),
];

investment_hydro = [
    Investment(
        HydroOperations(
            CapacityFactor(1.0, 0.9),
            Outage(nothing),
            Curtailment(nothing),
            0.0,
        ),
        HydroFinance(CapacityCredit(10.0, 1.0), LifeCycle(nothing), 0.0),
    ),
    Investment(
        HydroOperations(
            CapacityFactor(1.0, 0.9),
            Outage(nothing),
            Curtailment(nothing),
            0.0,
        ),
        HydroFinance(CapacityCredit(10.0, 1.0), LifeCycle(nothing), 0.0),
    ),
];

hydro_generators5(buses5) = [
    HydroFix(
        "HydroFix",
        true,
        buses5[2],
        0.0,
        0.0,
        TechHydro(
            0.600,
            PowerSystems.HY,
            (min = 0.0, max = 60.0),
            (min = 0.0, max = 60.0),
            nothing,
            nothing,
        ),
        Device[],
        Dict{String, Any}("Investment" => investment_hydro[1]),
    ),
    HydroDispatch(
        "HydroDispatch",
        true,
        buses5[3],
        0.0,
        0.0,
        TechHydro(
            0.600,
            PowerSystems.HY,
            (min = 0.0, max = 60.0),
            (min = 0.0, max = 60.0),
            (up = 10.0, down = 10.0),
            nothing,
        ),
        TwoPartCost(15.0, 0.0),
        1.0,
        0.2,
        0.5,
    ),
    Device[],
    Dict{String, Any}("Investment" => investment_hydro[2]),
];

investment_battery() = Investment(
    BatteryOperations(CapacityFactor(1.0, 0.9), Outage(nothing), 8, 0.0),
    BatteryFinance(CapacityCredit(10.0, 1.0), LifeCycle(nothing), 0.0),
)

battery5(buses5) = [GenericBattery(;
    name = "Bat",
    primemover = PowerSystems.BA,
    available = true,
    bus = buses5()[1],
    energy = 5.0,
    capacity = (min = 5.0, max = 100.0),
    rating = 70,
    activepower = 10.0,
    inputactivepowerlimits = (min = 0.0, max = 50.0),
    outputactivepowerlimits = (min = 0.0, max = 50.0),
    reactivepower = 0.0,
    reactivepowerlimits = (min = -50.0, max = 50.0),
    efficiency = (in = 0.80, out = 0.90),
    ext = Dict{String, Any}("Investment" => investment_battery),
)];

loadbus2_ts_DA = [
    0.792729978
    0.723201574
    0.710952098
    0.677672816
    0.668249175
    0.67166919
    0.687608809
    0.711821241
    0.756320618
    0.7984057
    0.827836527
    0.840362459
    0.84511032
    0.834592803
    0.822949221
    0.816941743
    0.824079963
    0.905735139
    0.989967048
    1
    0.991227765
    0.960842114
    0.921465115
    0.837001437
]

loadbus3_ts_DA = [
    0.831093782
    0.689863228
    0.666058513
    0.627033103
    0.624901388
    0.62858924
    0.650734211
    0.683424321
    0.750876413
    0.828347191
    0.884248576
    0.888523615
    0.87752169
    0.847534405
    0.8227661
    0.803809323
    0.813282799
    0.907575962
    0.98679848
    1
    0.990489904
    0.952520972
    0.906611479
    0.824307054
]

loadbus4_ts_DA = [
    0.871297342
    0.670489749
    0.642812243
    0.630092987
    0.652991383
    0.671971681
    0.716278493
    0.770885833
    0.810075243
    0.85562361
    0.892440566
    0.910660449
    0.922135467
    0.898416969
    0.879816542
    0.896390855
    0.978598576
    0.96523761
    1
    0.969626503
    0.901212601
    0.81894251
    0.771004923
    0.717847996
]

loads5(buses5) = [
    PowerLoad(
        "Bus2",
        true,
        buses5[2],
        PowerSystems.ConstantPower,
        3.0,
        0.9861,
        3.0,
        0.9861,
    ),
    PowerLoad(
        "Bus3",
        true,
        buses5[3],
        PowerSystems.ConstantPower,
        3.0,
        0.9861,
        3.0,
        0.9861,
    ),
    PowerLoad(
        "Bus4",
        true,
        buses5[4],
        PowerSystems.ConstantPower,
        4.0,
        1.3147,
        4.0,
        1.3147,
    ),
];

interruptible(buses5) = [InterruptibleLoad(
    "IloadBus4",
    true,
    buses5[4],
    PowerSystems.ConstantPower,
    0.10,
    0.0,
    0.10,
    0.0,
    TwoPartCost(150.0, 2400.0),
)]

reserve5(thermal_generators5) = [VariableReserve{ReserveUp}(
    "test_reserve",
    0.6,
    maximum([gen.tech.activepowerlimits[:max] for gen in thermal_generators5]),
)]

Iload_timeseries_DA = [
    [TimeArray(DayAhead, loadbus4_ts_DA)],
    [TimeArray(DayAhead + Day(1), loadbus4_ts_DA + 0.1 * rand(24))],
]

load_timeseries_DA = [
    [
        TimeArray(DayAhead, loadbus2_ts_DA),
        TimeArray(DayAhead, loadbus3_ts_DA),
        TimeArray(DayAhead, loadbus4_ts_DA),
    ],
    [
        TimeArray(DayAhead + Day(1), rand(24) * 0.1 + loadbus2_ts_DA),
        TimeArray(DayAhead + Day(1), rand(24) * 0.1 + loadbus3_ts_DA),
        TimeArray(DayAhead + Day(1), rand(24) * 0.1 + loadbus4_ts_DA),
    ],
]

ren_timeseries_DA = [
    [
        TimeSeries.TimeArray(DayAhead, solar_ts_DA),
        TimeSeries.TimeArray(DayAhead, wind_ts_DA),
        TimeSeries.TimeArray(DayAhead, wind_ts_DA),
    ],
    [
        TimeSeries.TimeArray(DayAhead + Day(1), rand(24) * 0.1 + solar_ts_DA),
        TimeSeries.TimeArray(DayAhead + Day(1), rand(24) * 0.1 + wind_ts_DA),
        TimeSeries.TimeArray(DayAhead + Day(1), rand(24) * 0.1 + wind_ts_DA),
    ],
];

hydro_timeseries_DA = [
    [TimeSeries.TimeArray(DayAhead, wind_ts_DA)],
    [TimeSeries.TimeArray(DayAhead + Day(1), rand(24) * 0.1 + wind_ts_DA)],
]

buses = buses5()
c_sys5 = System(
    buses,
    thermal_generators5(buses),
    loads5(buses),
    branches5(buses),
    battery5(buses5),
    100.0,
    nothing,
    nothing,
)
