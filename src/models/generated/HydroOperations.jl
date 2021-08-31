#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct HydroOperations <: AbstractOperations
        capcaity_factor::CapacityFactor
        outage_factor::Outage
        curtailment::Curtailment
        minimum_load_factor::Float64
        service_operations::Vector{ServiceOperations}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_factor::CapacityFactor`
- `outage_factor::Outage`
- `curtailment::Curtailment`
- `minimum_load_factor::Float64`: minloadfrac from ReEDS, validation range: (0, nothing), action if invalid: warn
- `service_operations::Vector{ServiceOperations}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct HydroOperations <: AbstractOperations
    capcaity_factor::CapacityFactor
    outage_factor::Outage
    curtailment::Curtailment
    "minloadfrac from ReEDS"
    minimum_load_factor::Float64
    service_operations::Vector{ServiceOperations}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function HydroOperations(
    capcaity_factor,
    outage_factor,
    curtailment,
    minimum_load_factor,
    service_operations = ServiceOperations[],
)
    HydroOperations(
        capcaity_factor,
        outage_factor,
        curtailment,
        minimum_load_factor,
        service_operations,
        InfrastructureSystemsInternal(),
    )
end

function HydroOperations(;
    capcaity_factor,
    outage_factor,
    curtailment,
    minimum_load_factor,
    service_operations = ServiceOperations[],
)
    HydroOperations(
        capcaity_factor,
        outage_factor,
        curtailment,
        minimum_load_factor,
        service_operations,
    )
end

# Constructor for demo purposes; non-functional.
function HydroOperations(::Nothing)
    HydroOperations(;
        capcaity_factor = CapacityFactor(nothing),
        outage_factor = Outage(nothing),
        curtailment = Curtailment(nothing),
        minimum_load_factor = 0.0,
        service_operations = ServiceOperations[],
    )
end

"""Get HydroOperations capcaity_factor."""
get_capcaity_factor(value::HydroOperations) = value.capcaity_factor
"""Get HydroOperations outage_factor."""
get_outage_factor(value::HydroOperations) = value.outage_factor
"""Get HydroOperations curtailment."""
get_curtailment(value::HydroOperations) = value.curtailment
"""Get HydroOperations minimum_load_factor."""
get_minimum_load_factor(value::HydroOperations) = value.minimum_load_factor
"""Get HydroOperations service_operations."""
get_service_operations(value::HydroOperations) = value.service_operations
"""Get HydroOperations internal."""
get_internal(value::HydroOperations) = value.internal
