#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct GenericOperations <: AbstractOperations
        capcaity_factor::CapacityFactor
        outage_factor::Outage
        service_operations::Vector{ServiceOperations}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capcaity_factor::CapacityFactor`
- `outage_factor::Outage`
- `service_operations::Vector{ServiceOperations}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct GenericOperations <: AbstractOperations
    capcaity_factor::CapacityFactor
    outage_factor::Outage
    service_operations::Vector{ServiceOperations}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function GenericOperations(
    capcaity_factor,
    outage_factor,
    service_operations = ServiceOperations[],
)
    GenericOperations(
        capcaity_factor,
        outage_factor,
        service_operations,
        InfrastructureSystemsInternal(),
    )
end

function GenericOperations(;
    capcaity_factor,
    outage_factor,
    service_operations = ServiceOperations[],
)
    GenericOperations(capcaity_factor, outage_factor, service_operations)
end

# Constructor for demo purposes; non-functional.
function GenericOperations(::Nothing)
    GenericOperations(;
        capcaity_factor = CapacityFactor(nothing),
        outage_factor = Outage(nothing),
        service_operations = ServiceOperations[],
    )
end

"""Get GenericOperations capcaity_factor."""
get_capcaity_factor(value::GenericOperations) = value.capcaity_factor
"""Get GenericOperations outage_factor."""
get_outage_factor(value::GenericOperations) = value.outage_factor
"""Get GenericOperations service_operations."""
get_service_operations(value::GenericOperations) = value.service_operations
"""Get GenericOperations internal."""
get_internal(value::GenericOperations) = value.internal
