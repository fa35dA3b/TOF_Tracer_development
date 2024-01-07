@testset "MasslistFunctions" begin
    @testset "IntegrationBorders" begin
	    @test_throws MethodError TOFTracer2.MasslistFunctions.IntegrationBorders()
	    cmasses = [59.1,63.05]
	    I = TOFTracer2.MasslistFunctions.IntegrationBorders(cmasses)
	    @test round.(I.lowMass,digits=5) == [59.0803,63.0303]
	    @test round.(I.highMass,digits=5) == [59.11970,63.07102]
	    @test I.centerMass == cmasses
	    
	    I = TOFTracer2.MasslistFunctions.IntegrationBorders(cmasses;resolution=10000)
	    @test round.(I.lowMass,digits=5) == [59.09409,63.04409]
	    @test round.(I.highMass,digits=5) == [ 59.10591,63.0563]
	    @test I.centerMass == cmasses
	end

    @testset "masslistPos" begin
        @test MasslistFunctions.masslistPos(10) == 10
        @test MasslistFunctions.masslistPos(0) == 0
        @test MasslistFunctions.masslistPos(-1) == 0
    end

    @testset "inCompositions" begin
        comp = [1, 1, 1, 1, 1, 1, 1, 1]
        comp_alien = [1, 0, 1, 1, 1, 1, 1, 1]
        comp_wrong = [1, 1, 1, 1, 1, 1, 1]
        complist = [[0, 1, 1, 1, 1, 1, 1, 1] [1, 1, 1, 1, 1, 1, 1, 1]]

        @test MasslistFunctions.inCompositions(comp, complist) == true
        @test MasslistFunctions.inCompositions(comp_alien, complist) == false
        @test_throws ArgumentError MasslistFunctions.inCompositions(comp_wrong, complist)
    end

    @testset "createMassList" begin
        @test MasslistFunctions.createMassList(C=0:2) == ([1.007276, 3.022936, 13.007276000000001, 15.022936000000001, 17.038596000000002, 25.007276, 27.022936, 29.038596000000002, 31.054256, 37.02], 
                                                            ["C", "C(13)", "H", "H+", "N", "O", "O(18)", "S"], 
                                                            [12.0, 13.00335, 1.00783, 1.007276, 14.00307, 15.99492, 17.99916, 31.97207], 
                                                            [[0 0 0 1 0 0 0 0], [0 0 2 1 0 0 0 0], [1 0 0 1 0 0 0 0], [1 0 2 1 0 0 0 0], [1 0 4 1 0 0 0 0], 
                                                            [2 0 0 1 0 0 0 0], [2 0 2 1 0 0 0 0], [2 0 4 1 0 0 0 0], [2 0 6 1 0 0 0 0], [0 0 4 1 0 2 0 0]]
                                                            )
    end
end