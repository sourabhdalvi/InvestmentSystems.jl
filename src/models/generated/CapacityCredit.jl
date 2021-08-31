#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct CapacityCredit <: FinancialParameter
        average::Float64
        marginal::Float64
        internal::InfrastructureSystemsInternal
    end

s

# Arguments
- `average::Float64`: average capacity credit, validation range: (0, nothing), action if invalid: warn
- `marginal::Float64`: marginal capacity credit, validation range: (0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct CapacityCredit <: FinancialParameter
    "average capacity credit"
    average::Float64
    "marginal capacity credit"
    marginal::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function CapacityCredit(average, marginal)
    CapacityCredit(average, marginal, InfrastructureSystemsInternal())
end

function CapacityCredit(; average, marginal)
    CapacityCredit(average, marginal)
end

# Constructor for demo purposes; non-functional.
function CapacityCredit(::Nothing)
    CapacityCredit(; average = 0.0, marginal = 0.0)
end

"""Get CapacityCredit average."""
get_average(value::CapacityCredit) = value.average
"""Get CapacityCredit marginal."""
get_marginal(value::CapacityCredit) = value.marginal
"""Get CapacityCredit internal."""
get_internal(value::CapacityCredit) = value.internal
