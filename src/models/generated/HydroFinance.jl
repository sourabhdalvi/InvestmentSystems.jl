#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct HydroFinance <: AbstractFinance
        capcaity_credit::CapacityCredit
        life_cycle::LifeCycle
        incentive::Float64
        project_cost::Union{Nothing, ProjectCost}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_credit::CapacityCredit`
- `life_cycle::LifeCycle`
- `incentive::Float64`, validation range: (0, nothing), action if invalid: warn
- `project_cost::Union{Nothing, ProjectCost}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct HydroFinance <: AbstractFinance
    capcaity_credit::CapacityCredit
    life_cycle::LifeCycle
    incentive::Float64
    project_cost::Union{Nothing, ProjectCost}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function HydroFinance(capcaity_credit, life_cycle, incentive, project_cost = nothing)
    HydroFinance(
        capcaity_credit,
        life_cycle,
        incentive,
        project_cost,
        InfrastructureSystemsInternal(),
    )
end

function HydroFinance(; capcaity_credit, life_cycle, incentive, project_cost = nothing)
    HydroFinance(capcaity_credit, life_cycle, incentive, project_cost)
end

# Constructor for demo purposes; non-functional.
function HydroFinance(::Nothing)
    HydroFinance(;
        capcaity_credit = CapacityCredit(nothing),
        life_cycle = LifeCycle(nothing),
        incentive = 0.0,
        project_cost = nothing,
    )
end

"""Get HydroFinance capcaity_credit."""
get_capcaity_credit(value::HydroFinance) = value.capcaity_credit
"""Get HydroFinance life_cycle."""
get_life_cycle(value::HydroFinance) = value.life_cycle
"""Get HydroFinance incentive."""
get_incentive(value::HydroFinance) = value.incentive
"""Get HydroFinance project_cost."""
get_project_cost(value::HydroFinance) = value.project_cost
"""Get HydroFinance internal."""
get_internal(value::HydroFinance) = value.internal
