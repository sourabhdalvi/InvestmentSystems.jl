#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct BatteryFinance <: AbstractFinance
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
mutable struct BatteryFinance <: AbstractFinance
    capcaity_credit::CapacityCredit
    life_cycle::LifeCycle
    incentive::Float64
    project_cost::Union{Nothing, ProjectCost}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function BatteryFinance(capcaity_credit, life_cycle, incentive, project_cost = nothing)
    BatteryFinance(
        capcaity_credit,
        life_cycle,
        incentive,
        project_cost,
        InfrastructureSystemsInternal(),
    )
end

function BatteryFinance(; capcaity_credit, life_cycle, incentive, project_cost = nothing)
    BatteryFinance(capcaity_credit, life_cycle, incentive, project_cost)
end

# Constructor for demo purposes; non-functional.
function BatteryFinance(::Nothing)
    BatteryFinance(;
        capcaity_credit = CapacityCredit(nothing),
        life_cycle = LifeCycle(nothing),
        incentive = 0.0,
        project_cost = nothing,
    )
end

"""Get BatteryFinance capcaity_credit."""
get_capcaity_credit(value::BatteryFinance) = value.capcaity_credit
"""Get BatteryFinance life_cycle."""
get_life_cycle(value::BatteryFinance) = value.life_cycle
"""Get BatteryFinance incentive."""
get_incentive(value::BatteryFinance) = value.incentive
"""Get BatteryFinance project_cost."""
get_project_cost(value::BatteryFinance) = value.project_cost
"""Get BatteryFinance internal."""
get_internal(value::BatteryFinance) = value.internal
