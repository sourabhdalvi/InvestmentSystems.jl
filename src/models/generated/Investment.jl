#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct Investment{T <: AbstractOperations, U <: AbstractFinance} <: AbstractInvestment
        operations::T
        finance::U
        retirement::Union{Nothing,Retirement}
        _forecasts::InfrastructureSystems.Forecasts
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `operations::T`
- `finance::U`: Financial parameters
- `retirement::Union{Nothing,Retirement}`
- `_forecasts::InfrastructureSystems.Forecasts`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct Investment{T <: AbstractOperations, U <: AbstractFinance} <:
               AbstractInvestment
    operations::T
    "Financial parameters"
    finance::U
    retirement::Union{Nothing, Retirement}
    _forecasts::InfrastructureSystems.Forecasts
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function Investment{T, U}(
    operations,
    finance,
    retirement = nothing,
    _forecasts = InfrastructureSystems.Forecasts(),
) where {T <: AbstractOperations, U <: AbstractFinance}
    Investment{T, U}(
        operations,
        finance,
        retirement,
        _forecasts,
        InfrastructureSystemsInternal(),
    )
end

function Investment{T, U}(;
    operations,
    finance,
    retirement = nothing,
    _forecasts = InfrastructureSystems.Forecasts(),
) where {T <: AbstractOperations, U <: AbstractFinance}
    Investment{T, U}(operations, finance, retirement, _forecasts)
end

function Investment(
    operations,
    finance,
    retirement = nothing,
    _forecasts = InfrastructureSystems.Forecasts(),
)
    Investment{typeof(operations), typeof(finance)}(
        operations,
        finance,
        retirement,
        _forecasts,
    )
end

# Constructor for demo purposes; non-functional.
function Investment{T, U}(::Nothing) where {T <: AbstractOperations, U <: AbstractFinance}
    Investment{T, U}(;
        operations = GenericOperations(nothing),
        finance = GenericFinance(nothing),
        retirement = nothing,
        _forecasts = InfrastructureSystems.Forecasts(),
    )
end

"""Get Investment operations."""
get_operations(value::Investment) = value.operations
"""Get Investment finance."""
get_finance(value::Investment) = value.finance
"""Get Investment retirement."""
get_retirement(value::Investment) = value.retirement
"""Get Investment _forecasts."""
get__forecasts(value::Investment) = value._forecasts
"""Get Investment internal."""
get_internal(value::Investment) = value.internal
