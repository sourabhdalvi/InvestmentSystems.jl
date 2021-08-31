#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct InterconnectionQueue <: ProjectParameter
        queue_time::Int64
        count::Int64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `queue_time::Int64`: The number of years required in the interconnection queue before the build decision can be made., validation range: (0, 99), action if invalid: warn
- `count::Int64`: Number of years spent in the queue process, validation range: (1, 99), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct InterconnectionQueue <: ProjectParameter
    "The number of years required in the interconnection queue before the build decision can be made."
    queue_time::Int64
    "Number of years spent in the queue process"
    count::Int64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function InterconnectionQueue(queue_time, count)
    InterconnectionQueue(queue_time, count, InfrastructureSystemsInternal())
end

function InterconnectionQueue(; queue_time, count)
    InterconnectionQueue(queue_time, count)
end

# Constructor for demo purposes; non-functional.
function InterconnectionQueue(::Nothing)
    InterconnectionQueue(; queue_time = 0, count = 0)
end

"""Get InterconnectionQueue queue_time."""
get_queue_time(value::InterconnectionQueue) = value.queue_time
"""Get InterconnectionQueue count."""
get_count(value::InterconnectionQueue) = value.count
"""Get InterconnectionQueue internal."""
get_internal(value::InterconnectionQueue) = value.internal
