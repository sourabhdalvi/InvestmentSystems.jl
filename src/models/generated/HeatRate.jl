#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct HeatRate <: OperationalParameter
        average::Union{Float64, Seasonal}
        startup::Union{Float64, Turbine_Temperature}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `average::Union{Float64, Seasonal}`
- `startup::Union{Float64, Turbine_Temperature}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct HeatRate <: OperationalParameter
    average::Union{Float64, Seasonal}
    startup::Union{Float64, Turbine_Temperature}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function HeatRate(average, startup)
    HeatRate(average, startup, InfrastructureSystemsInternal())
end

function HeatRate(; average, startup)
    HeatRate(average, startup)
end

# Constructor for demo purposes; non-functional.
function HeatRate(::Nothing)
    HeatRate(; average = 0.0, startup = 0.0)
end

"""Get HeatRate average."""
get_average(value::HeatRate) = value.average
"""Get HeatRate startup."""
get_startup(value::HeatRate) = value.startup
"""Get HeatRate internal."""
get_internal(value::HeatRate) = value.internal
