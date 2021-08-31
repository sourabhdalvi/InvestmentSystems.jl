#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Construction <: ProjectParameter
        construction_time::Int64
        count::Int64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `construction_time::Int64`: The number of years required to construct the plant after a build decision is made., validation range: (0, 99), action if invalid: warn
- `count::Int64`: Number of years spent in the construction process, validation range: (1, 99), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Construction <: ProjectParameter
    "The number of years required to construct the plant after a build decision is made."
    construction_time::Int64
    "Number of years spent in the construction process"
    count::Int64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Construction(construction_time, count)
    Construction(construction_time, count, InfrastructureSystemsInternal())
end

function Construction(; construction_time, count)
    Construction(construction_time, count)
end

# Constructor for demo purposes; non-functional.
function Construction(::Nothing)
    Construction(; construction_time = 0, count = 0)
end

"""Get Construction construction_time."""
get_construction_time(value::Construction) = value.construction_time
"""Get Construction count."""
get_count(value::Construction) = value.count
"""Get Construction internal."""
get_internal(value::Construction) = value.internal
