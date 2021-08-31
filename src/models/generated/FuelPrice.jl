#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct FuelPrice <: OperationalParameter
        fueltype::ThermalFuels
        price::Float64
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `fueltype::ThermalFuels`: type of fuel
- `price::Float64`, validation range: (0, nothing), action if invalid: warn
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct FuelPrice <: OperationalParameter
    "type of fuel"
    fueltype::ThermalFuels.ThermalFuel
    price::Float64
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function FuelPrice(fueltype, price)
    FuelPrice(fueltype, price, InfrastructureSystemsInternal())
end

function FuelPrice(; fueltype, price)
    FuelPrice(fueltype, price)
end

# Constructor for demo purposes; non-functional.
function FuelPrice(::Nothing)
    FuelPrice(; fueltype = ThermalFuels.OTHER, price = 0.0)
end

"""Get FuelPrice fueltype."""
get_fueltype(value::FuelPrice) = value.fueltype
"""Get FuelPrice price."""
get_price(value::FuelPrice) = value.price
"""Get FuelPrice internal."""
get_internal(value::FuelPrice) = value.internal
