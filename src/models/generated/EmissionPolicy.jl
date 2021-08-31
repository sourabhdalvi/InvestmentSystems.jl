#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct EmissionPolicy <: PolicyParameter
        pollutant::Pollutants
        tax::Float64
        limit::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `pollutant::Pollutants`: pollutant type
- `tax::Float64`: penalty on production, TODO: units [lb/hr], validation range: (0, nothing), action if invalid: warn
- `limit::Float64`: hard limit on production, validation range: (0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct EmissionPolicy <: PolicyParameter
    "pollutant type"
    pollutant::Pollutants.Pollutant
    "penalty on production, TODO: units [lb/hr]"
    tax::Float64
    "hard limit on production"
    limit::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function EmissionPolicy(pollutant, tax, limit)
    EmissionPolicy(pollutant, tax, limit, InfrastructureSystemsInternal())
end

function EmissionPolicy(; pollutant, tax, limit)
    EmissionPolicy(pollutant, tax, limit)
end

# Constructor for demo purposes; non-functional.
function EmissionPolicy(::Nothing)
    EmissionPolicy(; pollutant = Pollutants.OTH, tax = 0.0, limit = 0.0)
end

"""Get EmissionPolicy pollutant."""
get_pollutant(value::EmissionPolicy) = value.pollutant
"""Get EmissionPolicy tax."""
get_tax(value::EmissionPolicy) = value.tax
"""Get EmissionPolicy limit."""
get_limit(value::EmissionPolicy) = value.limit
"""Get EmissionPolicy internal."""
get_internal(value::EmissionPolicy) = value.internal
