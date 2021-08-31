using Revise
using PowerSystems
using InvestmentSystems
using Dates
const INS = InvestmentSystems
const PSY = PowerSystems

rts_dir1 = "../../Projects/Investment_RTS/RTS-GMLC/RTS_Data/SourceData/"
rawsys1 = PSY.PowerSystemTableData(
    rts_dir1,
    100.0,
    joinpath(rts_dir1, "../FormattedData/SIIP/user_descriptors.yaml"),
    ;
    timeseries_metadata_file = joinpath(
        rts_dir1,
        "../FormattedData/SIIP/timeseries_pointers.json",
    ),
    descriptor_file = "./src/descriptors/investment_system_inputs.json",
)

sys = INS.System(rawsys1; forecast_resolution = Dates.Hour(1))