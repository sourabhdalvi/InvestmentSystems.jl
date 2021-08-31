#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Node <: Topology
        name::String
        network::LoadZone
        _forecasts::InfrastructureSystems.Forecasts
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `name::String`: name of the region
- `network::LoadZone`: holds a vector of buses
- `_forecasts::InfrastructureSystems.Forecasts`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Node <: Topology
    "name of the region"
    name::String
    "holds a vector of buses"
    network::LoadZone
    _forecasts::InfrastructureSystems.Forecasts
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Node(name, network, _forecasts = InfrastructureSystems.Forecasts())
    Node(name, network, _forecasts, InfrastructureSystemsInternal())
end

function Node(; name, network, _forecasts = InfrastructureSystems.Forecasts())
    Node(name, network, _forecasts)
end

"""Get Node name."""
get_name(value::Node) = value.name
"""Get Node network."""
get_network(value::Node) = value.network
"""Get Node _forecasts."""
get__forecasts(value::Node) = value._forecasts
"""Get Node internal."""
get_internal(value::Node) = value.internal
