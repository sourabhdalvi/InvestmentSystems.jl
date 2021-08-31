#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct ProjectCost <: FinancialParameter
        capital_cost:: Union{CapitalCost, ResourceSupplyCurve}
        tax_rate::Float64
        discount_rate::Float64
        inflation_rate::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `capital_cost:: Union{CapitalCost, ResourceSupplyCurve}`: cost_cap from ReEDS
- `tax_rate::Float64`, validation range: (0, nothing), action if invalid: warn
- `discount_rate::Float64`, validation range: (0, nothing), action if invalid: warn
- `inflation_rate::Float64`: cost_cap_fin_mult parameter from ReEDS, validation range: (0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct ProjectCost <: FinancialParameter
    "cost_cap from ReEDS"
    capital_cost::Union{CapitalCost, ResourceSupplyCurve}
    tax_rate::Float64
    discount_rate::Float64
    "cost_cap_fin_mult parameter from ReEDS"
    inflation_rate::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function ProjectCost(capital_cost, tax_rate, discount_rate, inflation_rate)
    ProjectCost(
        capital_cost,
        tax_rate,
        discount_rate,
        inflation_rate,
        InfrastructureSystemsInternal(),
    )
end

function ProjectCost(; capital_cost, tax_rate, discount_rate, inflation_rate)
    ProjectCost(capital_cost, tax_rate, discount_rate, inflation_rate)
end

# Constructor for demo purposes; non-functional.
function ProjectCost(::Nothing)
    ProjectCost(;
        capital_cost = CapitalCost(0.0),
        tax_rate = 0.0,
        discount_rate = 0.0,
        inflation_rate = 0.0,
    )
end

"""Get ProjectCost capital_cost."""
get_capital_cost(value::ProjectCost) = value.capital_cost
"""Get ProjectCost tax_rate."""
get_tax_rate(value::ProjectCost) = value.tax_rate
"""Get ProjectCost discount_rate."""
get_discount_rate(value::ProjectCost) = value.discount_rate
"""Get ProjectCost inflation_rate."""
get_inflation_rate(value::ProjectCost) = value.inflation_rate
"""Get ProjectCost internal."""
get_internal(value::ProjectCost) = value.internal
