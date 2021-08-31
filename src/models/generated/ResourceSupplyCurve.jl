#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct ResourceSupplyCurve <: FinancialParameter
        cost::CapitalCost
        resource_scaler::Float64
        internal::InfrastructureSystemsInternal
    end

Resource Supply Curve for ReEDs

# Arguments
- `cost::CapitalCost`
- `resource_scaler::Float64`: resourcescaler parameter from ReEDS, validation range: (0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct ResourceSupplyCurve <: FinancialParameter
    cost::CapitalCost
    "resourcescaler parameter from ReEDS"
    resource_scaler::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function ResourceSupplyCurve(cost, resource_scaler)
    ResourceSupplyCurve(cost, resource_scaler, InfrastructureSystemsInternal())
end

function ResourceSupplyCurve(; cost, resource_scaler)
    ResourceSupplyCurve(cost, resource_scaler)
end

# Constructor for demo purposes; non-functional.
function ResourceSupplyCurve(::Nothing)
    ResourceSupplyCurve(; cost = CapitalCost((0.0, 0.0)), resource_scaler = 0.0)
end

"""Get ResourceSupplyCurve cost."""
get_cost(value::ResourceSupplyCurve) = value.cost
"""Get ResourceSupplyCurve resource_scaler."""
get_resource_scaler(value::ResourceSupplyCurve) = value.resource_scaler
"""Get ResourceSupplyCurve internal."""
get_internal(value::ResourceSupplyCurve) = value.internal
