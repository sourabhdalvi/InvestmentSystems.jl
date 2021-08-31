#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct RenewableFinance <: AbstractFinance
        capcaity_credit::CapacityCredit
        life_cycle::LifeCycle
        incentive::Float64
        project_cost::Union{Nothing, ProjectCost}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_credit::CapacityCredit`
- `life_cycle::LifeCycle`
- `incentive::Float64`: gen_pol from ReEDS, validation range: (0, nothing), action if invalid: warn
- `project_cost::Union{Nothing, ProjectCost}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct RenewableFinance <: AbstractFinance
    capacity_credit::CapacityCredit
    life_cycle::LifeCycle
    "gen_pol from ReEDS"
    incentive::Float64
    project_cost::Union{Nothing, ProjectCost}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function RenewableFinance(capacity_credit, life_cycle, incentive, project_cost = nothing)
    RenewableFinance(
        capacity_credit,
        life_cycle,
        incentive,
        project_cost,
        InfrastructureSystemsInternal(),
    )
end

function RenewableFinance(; capacity_credit, life_cycle, incentive, project_cost = nothing)
    RenewableFinance(capacity_credit, life_cycle, incentive, project_cost)
end

# Constructor for demo purposes; non-functional.
function RenewableFinance(::Nothing)
    RenewableFinance(;
        capacity_credit = CapacityCredit(nothing),
        life_cycle = LifeCycle(nothing),
        incentive = 0.0,
        project_cost = nothing,
    )
end

"""Get RenewableFinance capcaity_credit."""
get_capacity_credit(value::RenewableFinance) = value.capacity_credit
"""Get RenewableFinance life_cycle."""
get_life_cycle(value::RenewableFinance) = value.life_cycle
"""Get RenewableFinance incentive."""
get_incentive(value::RenewableFinance) = value.incentive
"""Get RenewableFinance project_cost."""
get_project_cost(value::RenewableFinance) = value.project_cost
"""Get RenewableFinance internal."""
get_internal(value::RenewableFinance) = value.internal
