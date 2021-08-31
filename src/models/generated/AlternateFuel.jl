#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct AlternateFuel <: OperationalParameter
        secondary_fuel::ThermalFuels.ThermalFuel
        fuel_ratio::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `secondary_fuel::ThermalFuels.ThermalFuel`
- `fuel_ratio::Float64`, validation range: (0.0, 1.0), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct AlternateFuel <: OperationalParameter
    secondary_fuel::ThermalFuels.ThermalFuel
    fuel_ratio::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function AlternateFuel(secondary_fuel, fuel_ratio)
    AlternateFuel(secondary_fuel, fuel_ratio, InfrastructureSystemsInternal())
end

function AlternateFuel(; secondary_fuel, fuel_ratio)
    AlternateFuel(secondary_fuel, fuel_ratio)
end

# Constructor for demo purposes; non-functional.
function AlternateFuel(::Nothing)
    AlternateFuel(; secondary_fuel = ThermalFuels.OTHER, fuel_ratio = 0.0)
end

"""Get AlternateFuel secondary_fuel."""
get_secondary_fuel(value::AlternateFuel) = value.secondary_fuel
"""Get AlternateFuel fuel_ratio."""
get_fuel_ratio(value::AlternateFuel) = value.fuel_ratio
"""Get AlternateFuel internal."""
get_internal(value::AlternateFuel) = value.internal
