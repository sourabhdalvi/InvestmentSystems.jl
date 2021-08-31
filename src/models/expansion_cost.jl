const CostLag = NamedTuple{(:cost, :lag), Tuple{Float64, Float64}}
const CapCostArgs = Union{Float64, CostLag, Vector{CostLag}}

mutable struct CapitalCost{T}
    cost::T
end

get_cost(vc::InvestmentSystems.CapitalCost) = vc.cost
Base.length(vc::InvestmentSystems.CapitalCost) = length(vc.cost)
Base.getindex(vc::InvestmentSystems.CapitalCost, ix::Int64) = getindex(vc.cost, ix)
