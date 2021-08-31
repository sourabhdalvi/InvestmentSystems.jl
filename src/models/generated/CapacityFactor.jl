#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct CapacityFactor <: OperationalParameter
        average::Float64
        seasonal::Float64
        internal::InfrastructureSystemsInternal
    end

s

# Arguments
- `average::Float64`: average capacity factor, validation range: (0, 1), action if invalid: warn
- `seasonal::Float64`: seasonal capacity factor, validation range: (0, 1), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct CapacityFactor <: OperationalParameter
    "average capacity factor"
    average::Float64
    "seasonal capacity factor"
    seasonal::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function CapacityFactor(average, seasonal)
    CapacityFactor(average, seasonal, InfrastructureSystemsInternal())
end

function CapacityFactor(; average, seasonal)
    CapacityFactor(average, seasonal)
end

# Constructor for demo purposes; non-functional.
function CapacityFactor(::Nothing)
    CapacityFactor(; average = 0.0, seasonal = 0.0)
end

"""Get CapacityFactor average."""
get_average(value::CapacityFactor) = value.average
"""Get CapacityFactor seasonal."""
get_seasonal(value::CapacityFactor) = value.seasonal
"""Get CapacityFactor internal."""
get_internal(value::CapacityFactor) = value.internal
