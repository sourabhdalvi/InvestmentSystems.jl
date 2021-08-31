#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct LifeCycle <: ProjectParameter
        lifetime::Int64
        build_year::Int64
        project_phase::ProjectPhase
        available::After_Before
        construction::Union{Nothing,Construction}
        queue_time::Union{Nothing,InterconnectionQueue}
        internal::InfrastructureSystemsInternal
    end

Includes all details regarding plant Lifetime, Build year etc.

# Arguments
- `lifetime::Int64`: Expected lifetime of the plant before it has to be retired., validation range: (1, 99), action if invalid: warn
- `build_year::Int64`: Year in which the plant was build., validation range: (1900, 2999), action if invalid: warn
- `project_phase::ProjectPhase`: current state of the project
- `available::After_Before`: The years when this technology is available to build.
- `construction::Union{Nothing,Construction}`
- `queue_time::Union{Nothing,InterconnectionQueue}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct LifeCycle <: ProjectParameter
    "Expected lifetime of the plant before it has to be retired."
    lifetime::Int64
    "Year in which the plant was build."
    build_year::Int64
    "current state of the project"
    project_phase::ProjectPhases.ProjectPhase
    "The years when this technology is available to build."
    available::After_Before
    construction::Union{Nothing, Construction}
    queue_time::Union{Nothing, InterconnectionQueue}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function LifeCycle(
    lifetime,
    build_year,
    project_phase,
    available,
    construction = nothing,
    queue_time = nothing,
)
    LifeCycle(
        lifetime,
        build_year,
        project_phase,
        available,
        construction,
        queue_time,
        InfrastructureSystemsInternal(),
    )
end

function LifeCycle(;
    lifetime,
    build_year,
    project_phase,
    available,
    construction = nothing,
    queue_time = nothing,
)
    LifeCycle(lifetime, build_year, project_phase, available, construction, queue_time)
end

# Constructor for demo purposes; non-functional.
function LifeCycle(::Nothing)
    LifeCycle(;
        lifetime = 1,
        build_year = 1900,
        project_phase = ProjectPhases.COMPLETED,
        available = (after = 1900, before = 2999),
        construction = nothing,
        queue_time = nothing,
    )
end

"""Get LifeCycle lifetime."""
get_lifetime(value::LifeCycle) = value.lifetime
"""Get LifeCycle build_year."""
get_build_year(value::LifeCycle) = value.build_year
"""Get LifeCycle project_phase."""
get_project_phase(value::LifeCycle) = value.project_phase
"""Get LifeCycle available."""
get_available(value::LifeCycle) = value.available
"""Get LifeCycle construction."""
get_construction(value::LifeCycle) = value.construction
"""Get LifeCycle queue_time."""
get_queue_time(value::LifeCycle) = value.queue_time
"""Get LifeCycle internal."""
get_internal(value::LifeCycle) = value.internal
