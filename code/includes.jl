using PyPlot

PyPlot.rc("figure", figsize=(12,4))

include("plotting.jl")

@everywhere using Distributions
@everywhere include("load_data.jl")
@everywhere include("ode_solver.jl")
@everywhere include("utils.jl")
@everywhere include("montecarlos.jl")