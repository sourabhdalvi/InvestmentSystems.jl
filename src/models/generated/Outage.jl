#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Outage <: OperationalParameter
        forced_rate::Float64
        planned_rate::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `forced_rate::Float64`: Forced outage rate, validation range: (&quot;0.0&quot;, &quot;1.0&quot;), action if invalid: warn
- `planned_rate::Float64`: Planned outage rate, validation range: (&quot;0.0&quot;, &quot;1.0&quot;), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Outage <: OperationalParameter
    "Forced outage rate"
    forced_rate::Float64
    "Planned outage rate"
    planned_rate::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Outage(forced_rate, planned_rate)
    Outage(forced_rate, planned_rate, InfrastructureSystemsInternal())
end

function Outage(; forced_rate, planned_rate)
    Outage(forced_rate, planned_rate)
end

# Constructor for demo purposes; non-functional.
function Outage(::Nothing)
    Outage(; forced_rate = 0.0, planned_rate = 0.0)
end

"""Get Outage forced_rate."""
get_forced_rate(value::Outage) = value.forced_rate
"""Get Outage planned_rate."""
get_planned_rate(value::Outage) = value.planned_rate
"""Get Outage internal."""
get_internal(value::Outage) = value.internal
