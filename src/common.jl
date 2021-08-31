
const After_Before = NamedTuple{(:after, :before), Tuple{Float64, Float64}}

const Turbine_Temperature =
    NamedTuple{(:hot, :warm, :cold), Tuple{Float64, Float64, Float64}}

const Seasonal = NamedTuple{(:winter, :summer), Tuple{Float64, Float64}}

const INVESTMENT_SYSTEM_STRUCT_DESCRIPTOR_FILE = joinpath(
    dirname(pathof(InvestmentSystems)),
    "descriptors",
    "investment_system_structs.json",
)

IS.@scoped_enum  Pollutant begin
    CO2    # Carbon Dioxide
    SO2    # Sulfur Dioxide
    HG     # Mercury
    NOX    # Nitrogen Oxides
    OTH    # Other
end

IS.@scoped_enum ProjectPhase begin
    PROPOSED
    PLANNED
    COMPLETED
    RETIRED
end

const STRING2PROJECTPHASE = Dict((string(e) => e) for e in instances(ProjectPhases.ProjectPhase))
merge!(
    STRING2PROJECTPHASE,
    Dict(
        "PROPOSED" => ProjectPhases.PROPOSED,
        "PLANNED" => ProjectPhases.PLANNED,
        "COMPLETED" => ProjectPhases.COMPLETED,
        "RETIRED" => ProjectPhases.RETIRED,
    ),
)

const STRING2POLLUTANTS = Dict((string(e) => e) for e in instances(Pollutants.Pollutant))
merge!(
    STRING2POLLUTANTS,
    Dict(
        "CO2" => Pollutants.CO2,
        "SO2" => Pollutants.SO2,
        "HG" =>  Pollutants.HG,
        "NOX" => Pollutants.NOX,
        "OTH" => Pollutants.OTH
    ),
)

function Base.convert(::Type{ProjectPhases.ProjectPhase}, phase::AbstractString)
    return STRING2PROJECTPHASE[uppercase(phase)]
end

function Base.convert(::Type{ProjectPhases.ProjectPhase}, phase::Symbol)
    return convert(ProjectPhases.ProjectPhase, string(phase))
end

function Base.convert(::Type{Pollutants.Pollutant}, pollutant::AbstractString)
    return STRING2POLLUTANTS[uppercase(pollutant)]
end

function Base.convert(::Type{Pollutants.Pollutant}, pollutant::Symbol)
    return convert(Pollutants.Pollutant, string(pollutant))
end