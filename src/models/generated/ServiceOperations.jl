#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct ServiceOperations{T <: Service} <: OperationalParameter
        service::T
        cost::VariableCost
        contribution::Min_Max
        internal::InfrastructureSystemsInternal
    end

Cost of providing a particular service

# Arguments
- `service::T`: Service from PowerSystems
- `cost::VariableCost`: Regulation reserve product
- `contribution::Min_Max`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct ServiceOperations{T <: Service} <: OperationalParameter
    "Service from PowerSystems"
    service::T
    "Regulation reserve product"
    cost::VariableCost
    contribution::Min_Max
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function ServiceOperations{T}(service, cost, contribution) where {T <: Service}
    ServiceOperations{T}(service, cost, contribution, InfrastructureSystemsInternal())
end

function ServiceOperations{T}(; service, cost, contribution) where {T <: Service}
    ServiceOperations{T}(service, cost, contribution)
end

function ServiceOperations(service, cost, contribution)
    ServiceOperations{typeof(service)}(service, cost, contribution)
end

# Constructor for demo purposes; non-functional.
function ServiceOperations{T}(::Nothing) where {T <: Service}
    ServiceOperations{T}(;
        service = StaticReserve{ReserveUp}(nothing),
        cost = VariableCost((0.0, 0.0)),
        contribution = (min = 0.0, max = 1.0),
    )
end

"""Get ServiceOperations service."""
get_service(value::ServiceOperations) = value.service
"""Get ServiceOperations cost."""
get_cost(value::ServiceOperations) = value.cost
"""Get ServiceOperations contribution."""
get_contribution(value::ServiceOperations) = value.contribution
"""Get ServiceOperations internal."""
get_internal(value::ServiceOperations) = value.internal
