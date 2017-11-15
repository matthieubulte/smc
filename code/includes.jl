using PyPlot

include("plotting.jl")

@everywhere using Distributions
@everywhere include("load_data.jl")
@everywhere include("ode_solver.jl")
@everywhere include("utils.jl")
@everywhere include("montecarlos.jl")