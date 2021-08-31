struct InvestmentSystem <: PowerSystemType
    data::IS.SystemData
    internal::IS.InfrastructureSystemsInternal

    function InvestmentSystem(data, internal; kwargs...)
        sys = new(data, internal)
        return sys
    end
end
