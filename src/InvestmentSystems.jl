isdefined(Base, :__precompile__) && __precompile__()

"""
Module for constructing self-contained investment system objects.
"""
module InvestmentSystems

#################################################################################
# Exports

export InvestmentComponent
export InvestmentParameter
export PolicyParameter
export FinancialParameter
export ProjectParameter
export OperationalParameter

export AbstractInvestment
export AbstractOperations
export AbstractFinance

export Node
export Zone
export Region

export CapacityCredit
export CapacityFactor
export EmissionPolicy
export FuelPrice
export ResourceSupplyCurve
export ProjectCost
export ProjectPhases
export Pollutants
export CapitalCost

export AlternateFuel
export Construction
export Curtailment
export Emission
export HeatRate
export InterconnectionQueue
export LifeCycle
export Outage
export ProjectCost
export Retirement
export ServiceOperations

export GenericOperations
export BatteryOperations
export HydroOperations
export RenewableOperations
export ThermalOperations

export BatteryFinance
export HydroFinance
export GenericFinance
export RenewableFinance
export Investment

#################################################################################
# Imports
import InfrastructureSystems
import InfrastructureSystems: Components, InfrastructureSystemsInternal

import PowerSystems
import JSON
import Mustache
import ReusePatterns
import ReusePatterns: forward
import PowerSystems
import PowerSystems:
    Component,
    DeviceParameter,
    StaticReserve,
    ReserveUp,
    Service,
    VariableCost,
    ThermalFuels,
    PrimeMovers,
    InputCategory,
    LoadZone,
    Min_Max,
    Topology,
    PowerSystemTableData,
    System

const IS = InfrastructureSystems
const PSY = PowerSystems
#################################################################################
# Includes
# abstract type InvestmentSystemType <: IS.InfrastructureSystemsType end

abstract type InvestmentComponent <: Component end
abstract type InvestmentParameter <: DeviceParameter end
abstract type PolicyParameter <: InvestmentParameter end
abstract type FinancialParameter <: InvestmentParameter end
abstract type ProjectParameter <: InvestmentParameter end
abstract type OperationalParameter <: InvestmentParameter end

include("common.jl")

include("models/expansion_cost.jl")
include("models/investments.jl")
include("models/generated/includes.jl")

include("utils/print.jl")
include("utils/generate_structs.jl")
include("parsers/investment_system_table_data.jl")
end # module
