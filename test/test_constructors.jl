@testset "Finance Constructors" begin
    tLifeCycle = LifeCycle(nothing)
    @test tLifeCycle isa InvestmentSystemType
    tProjectCost = ProjectCost(nothing)
    @test tProjectCost isa InvestmentSystemType
    tCapacityCredit = CapacityCredit(nothing)
    @test tCapacityCredit isa InvestmentSystemType
    tBatteryFinance = BatteryFinance(nothing)
    @test tBatteryFinance isa InvestmentSystemType
    tGenericFinance = GenericFinance(nothing)
    @test tGenericFinance isa InvestmentSystemType
    tRenewableFinance = RenewableFinance(nothing)
    @test tRenewableFinance isa InvestmentSystemType
    tHydroFinance = HydroFinance(nothing)
    @test tHydroFinance isa InvestmentSystemType
end

@testset "Operations Constructors" begin
    tCapacityFactor = CapacityFactor(nothing)
    @test tCapacityFactor isa InvestmentSystemType
    tOutage = Outage(nothing)
    @test tOutage isa InvestmentSystemType
    tHeatRate = HeatRate(nothing)
    @test tHeatRate isa InvestmentSystemType
    tEmission = Emission(nothing)
    @test tEmission isa InvestmentSystemType
    tServiceOperations = ServiceOperations{StaticReserve{ReserveUp}}(nothing)
    @test tServiceOperations isa InvestmentSystemType
    tAlternateFuel = AlternateFuel(nothing)
    @test tAlternateFuel isa InvestmentSystemType
    tFuelPrice = FuelPrice(nothing)
    @test tFuelPrice isa InvestmentSystemType
    tCurtailment = Curtailment(nothing)
    @test tCurtailment isa InvestmentSystemType
    tBatteryOperations = BatteryOperations(nothing)
    @test tBatteryOperations isa InvestmentSystemType
    tHydroOperations = HydroOperations(nothing)
    @test tHydroOperations isa InvestmentSystemType
    tGenericOperations = GenericOperations(nothing)
    @test tGenericOperations isa InvestmentSystemType
    tRenewableOperations = RenewableOperations(nothing)
    @test tRenewableOperations isa InvestmentSystemType
    tThermalOperations = ThermalOperations(nothing)
    @test tThermalOperations isa InvestmentSystemType
end
