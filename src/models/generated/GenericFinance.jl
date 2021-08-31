#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct GenericFinance <: AbstractFinance
        life_cycle::LifeCycle
        project_cost::Union{Nothing, ProjectCost}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `life_cycle::LifeCycle`
- `project_cost::Union{Nothing, ProjectCost}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct GenericFinance <: AbstractFinance
    life_cycle::LifeCycle
    project_cost::Union{Nothing, ProjectCost}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function GenericFinance(life_cycle, project_cost = nothing)
    GenericFinance(life_cycle, project_cost, InfrastructureSystemsInternal())
end

function GenericFinance(; life_cycle, project_cost = nothing)
    GenericFinance(life_cycle, project_cost)
end

# Constructor for demo purposes; non-functional.
function GenericFinance(::Nothing)
    GenericFinance(; life_cycle = LifeCycle(nothing), project_cost = nothing)
end

"""Get GenericFinance life_cycle."""
get_life_cycle(value::GenericFinance) = value.life_cycle
"""Get GenericFinance project_cost."""
get_project_cost(value::GenericFinance) = value.project_cost
"""Get GenericFinance internal."""
get_internal(value::GenericFinance) = value.internal
