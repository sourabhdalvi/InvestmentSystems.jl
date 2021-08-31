#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct RenewableOperations <: AbstractOperations
        capcaity_factor::CapacityFactor
        outage_factor::Outage
        curtailment::Curtailment
        minimum_load_factor::Float64
        growth_rate::Float64
        service_operations::Vector{ServiceOperations}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_factor::CapacityFactor`
- `outage_factor::Outage`
- `curtailment::Curtailment`
- `minimum_load_factor::Float64`: minloadfrac from ReEDS, validation range: (0, nothing), action if invalid: warn
- `growth_rate::Float64`:  growth_limit_relative from ReEDS, validation range: (0, nothing), action if invalid: warn
- `service_operations::Vector{ServiceOperations}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct RenewableOperations <: AbstractOperations
    capcaity_factor::CapacityFactor
    outage_factor::Outage
    curtailment::Curtailment
    "minloadfrac from ReEDS"
    minimum_load_factor::Float64
    " growth_limit_relative from ReEDS"
    growth_rate::Float64
    service_operations::Vector{ServiceOperations}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function RenewableOperations(
    capcaity_factor,
    outage_factor,
    curtailment,
    minimum_load_factor,
    growth_rate,
    service_operations = ServiceOperations[],
)
    RenewableOperations(
        capcaity_factor,
        outage_factor,
        curtailment,
        minimum_load_factor,
        growth_rate,
        service_operations,
        InfrastructureSystemsInternal(),
    )
end

function RenewableOperations(;
    capcaity_factor,
    outage_factor,
    curtailment,
    minimum_load_factor,
    growth_rate,
    service_operations = ServiceOperations[],
)
    RenewableOperations(
        capcaity_factor,
        outage_factor,
        curtailment,
        minimum_load_factor,
        growth_rate,
        service_operations,
    )
end

# Constructor for demo purposes; non-functional.
function RenewableOperations(::Nothing)
    RenewableOperations(;
        capcaity_factor = CapacityFactor(nothing),
        outage_factor = Outage(nothing),
        curtailment = Curtailment(nothing),
        minimum_load_factor = 0.0,
        growth_rate = 0.0,
        service_operations = ServiceOperations[],
    )
end

"""Get RenewableOperations capcaity_factor."""
get_capcaity_factor(value::RenewableOperations) = value.capcaity_factor
"""Get RenewableOperations outage_factor."""
get_outage_factor(value::RenewableOperations) = value.outage_factor
"""Get RenewableOperations curtailment."""
get_curtailment(value::RenewableOperations) = value.curtailment
"""Get RenewableOperations minimum_load_factor."""
get_minimum_load_factor(value::RenewableOperations) = value.minimum_load_factor
"""Get RenewableOperations growth_rate."""
get_growth_rate(value::RenewableOperations) = value.growth_rate
"""Get RenewableOperations service_operations."""
get_service_operations(value::RenewableOperations) = value.service_operations
"""Get RenewableOperations internal."""
get_internal(value::RenewableOperations) = value.internal
