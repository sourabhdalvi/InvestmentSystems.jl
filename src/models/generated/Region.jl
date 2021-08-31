#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Region <: Topology
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
mutable struct Region <: Topology
    "name of the region"
    name::String
    "holds a vector of buses"
    network::LoadZone
    _forecasts::InfrastructureSystems.Forecasts
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Region(name, network, _forecasts = InfrastructureSystems.Forecasts())
    Region(name, network, _forecasts, InfrastructureSystemsInternal())
end

function Region(; name, network, _forecasts = InfrastructureSystems.Forecasts())
    Region(name, network, _forecasts)
end

"""Get Region name."""
get_name(value::Region) = value.name
"""Get Region network."""
get_network(value::Region) = value.network
"""Get Region _forecasts."""
get__forecasts(value::Region) = value._forecasts
"""Get Region internal."""
get_internal(value::Region) = value.internal
