#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Retirement <: ProjectParameter
        eligible_capacity::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `eligible_capacity::Float64`, validation range: (0.0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Retirement <: ProjectParameter
    eligible_capacity::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Retirement(eligible_capacity)
    Retirement(eligible_capacity, InfrastructureSystemsInternal())
end

function Retirement(; eligible_capacity)
    Retirement(eligible_capacity)
end

# Constructor for demo purposes; non-functional.
function Retirement(::Nothing)
    Retirement(; eligible_capacity = 0.0)
end

"""Get Retirement eligible_capacity."""
get_eligible_capacity(value::Retirement) = value.eligible_capacity
"""Get Retirement internal."""
get_internal(value::Retirement) = value.internal
