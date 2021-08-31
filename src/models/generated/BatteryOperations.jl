#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct BatteryOperations <: AbstractOperations
        capcaity_factor::CapacityFactor
        outage_factor::Outage
        duration::Float64
        curtailment_reduction::Float64
        service_operations::Vector{ServiceOperations}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_factor::CapacityFactor`
- `outage_factor::Outage`
- `duration::Float64`: storage_duration from ReEDS, validation range: (0, nothing), action if invalid: warn
- `curtailment_reduction::Float64`: curt_storage from ReEDS, validation range: (0, nothing), action if invalid: warn
- `service_operations::Vector{ServiceOperations}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct BatteryOperations <: AbstractOperations
    capcaity_factor::CapacityFactor
    outage_factor::Outage
    "storage_duration from ReEDS"
    duration::Float64
    "curt_storage from ReEDS"
    curtailment_reduction::Float64
    service_operations::Vector{ServiceOperations}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function BatteryOperations(
    capcaity_factor,
    outage_factor,
    duration,
    curtailment_reduction,
    service_operations = ServiceOperations[],
)
    BatteryOperations(
        capcaity_factor,
        outage_factor,
        duration,
        curtailment_reduction,
        service_operations,
        InfrastructureSystemsInternal(),
    )
end

function BatteryOperations(;
    capcaity_factor,
    outage_factor,
    duration,
    curtailment_reduction,
    service_operations = ServiceOperations[],
)
    BatteryOperations(
        capcaity_factor,
        outage_factor,
        duration,
        curtailment_reduction,
        service_operations,
    )
end

# Constructor for demo purposes; non-functional.
function BatteryOperations(::Nothing)
    BatteryOperations(;
        capcaity_factor = CapacityFactor(nothing),
        outage_factor = Outage(nothing),
        duration = 0.0,
        curtailment_reduction = 0.0,
        service_operations = ServiceOperations[],
    )
end

"""Get BatteryOperations capcaity_factor."""
get_capcaity_factor(value::BatteryOperations) = value.capcaity_factor
"""Get BatteryOperations outage_factor."""
get_outage_factor(value::BatteryOperations) = value.outage_factor
"""Get BatteryOperations duration."""
get_duration(value::BatteryOperations) = value.duration
"""Get BatteryOperations curtailment_reduction."""
get_curtailment_reduction(value::BatteryOperations) = value.curtailment_reduction
"""Get BatteryOperations service_operations."""
get_service_operations(value::BatteryOperations) = value.service_operations
"""Get BatteryOperations internal."""
get_internal(value::BatteryOperations) = value.internal
