#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Zone <: Topology
        name::String
        network::LoadZone
        induced_curtailment::Float64
        planning_reserve_requirement::Float64
        emission_policy::Vector{EmissionPolicy}
        _forecasts::InfrastructureSystems.Forecasts
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `name::String`: name of the region
- `network::LoadZone`: holds a vector of buses
- `induced_curtailment::Float64`:  induced_curtailment parameter from ReEDS, validation range: (0, nothing), action if invalid: warn
- `planning_reserve_requirement::Float64`:  prm parameter from ReEDS, validation range: (0, nothing), action if invalid: warn
- `emission_policy::Vector{EmissionPolicy}`: holds a vector of emissions
- `_forecasts::InfrastructureSystems.Forecasts`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Zone <: Topology
    "name of the region"
    name::String
    "holds a vector of buses"
    network::LoadZone
    " induced_curtailment parameter from ReEDS"
    induced_curtailment::Float64
    " prm parameter from ReEDS"
    planning_reserve_requirement::Float64
    "holds a vector of emissions"
    emission_policy::Vector{EmissionPolicy}
    _forecasts::InfrastructureSystems.Forecasts
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Zone(
    name,
    network,
    induced_curtailment,
    planning_reserve_requirement,
    emission_policy = EmissionPolicy[],
    _forecasts = InfrastructureSystems.Forecasts(),
)
    Zone(
        name,
        network,
        induced_curtailment,
        planning_reserve_requirement,
        emission_policy,
        _forecasts,
        InfrastructureSystemsInternal(),
    )
end

function Zone(;
    name,
    network,
    induced_curtailment,
    planning_reserve_requirement,
    emission_policy = EmissionPolicy[],
    _forecasts = InfrastructureSystems.Forecasts(),
)
    Zone(
        name,
        network,
        induced_curtailment,
        planning_reserve_requirement,
        emission_policy,
        _forecasts,
    )
end

"""Get Zone name."""
get_name(value::Zone) = value.name
"""Get Zone network."""
get_network(value::Zone) = value.network
"""Get Zone induced_curtailment."""
get_induced_curtailment(value::Zone) = value.induced_curtailment
"""Get Zone planning_reserve_requirement."""
get_planning_reserve_requirement(value::Zone) = value.planning_reserve_requirement
"""Get Zone emission_policy."""
get_emission_policy(value::Zone) = value.emission_policy
"""Get Zone _forecasts."""
get__forecasts(value::Zone) = value._forecasts
"""Get Zone internal."""
get_internal(value::Zone) = value.internal
