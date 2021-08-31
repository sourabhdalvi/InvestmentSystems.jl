#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Emission <: OperationalParameter
        pollutant::Pollutants
        emission_rate::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `pollutant::Pollutants`: type of pollutant
- `emission_rate::Float64`: TODO: units in [lb/hr] or [tons/year], validation range: (0.0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Emission <: OperationalParameter
    "type of pollutant"
    pollutant::Pollutants.Pollutant
    "TODO: units in [lb/hr] or [tons/year]"
    emission_rate::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Emission(pollutant, emission_rate)
    Emission(pollutant, emission_rate, InfrastructureSystemsInternal())
end

function Emission(; pollutant, emission_rate)
    Emission(pollutant, emission_rate)
end

# Constructor for demo purposes; non-functional.
function Emission(::Nothing)
    Emission(; pollutant = OTH::Pollutants.Pollutant, emission_rate = 0.0)
end

"""Get Emission pollutant."""
get_pollutant(value::Emission) = value.pollutant
"""Get Emission emission_rate."""
get_emission_rate(value::Emission) = value.emission_rate
"""Get Emission internal."""
get_internal(value::Emission) = value.internal
