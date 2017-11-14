using PyPlot

@everywhere using Distributions
@everywhere include("load_data.jl")
@everywhere include("ode_solver.jl")
@everywhere include("utils.jl")