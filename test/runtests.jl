using TOFTracer2

using Test
using HDF5
# using Suppressor
# using Documenter

@testset "allTests" begin

	include("./MasslistFunctions_tests.jl")
	#include("./test_processingWorkflow.jl")

end
