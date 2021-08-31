#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Curtailment <: OperationalParameter
        average::Float64
        marginal::Float64
    end



# Arguments
- `average::Float64`: average curtailment rate , validation range: (0, nothing), action if invalid: warn
- `marginal::Float64`: marginal curtailment rate, validation range: (0, nothing), action if invalid: warn
"""
mutable struct Curtailment <: OperationalParameter
    "average curtailment rate "
    average::Float64
    "marginal curtailment rate"
    marginal::Float64
end

function Curtailment(; average, marginal)
    Curtailment(average, marginal)
end

# Constructor for demo purposes; non-functional.
function Curtailment(::Nothing)
    Curtailment(; average = 0.0, marginal = 0.0)
end

"""Get Curtailment average."""
get_average(value::Curtailment) = value.average
"""Get Curtailment marginal."""
get_marginal(value::Curtailment) = value.marginal
