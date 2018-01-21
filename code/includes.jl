using PyPlot
using Interact

PyPlot.rc("figure", figsize=(10,8))

include("plotting.jl")

@everywhere using Distributions
@everywhere include("load_data.jl")
@everywhere include("ode_solver.jl")