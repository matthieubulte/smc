using PyPlot
using Interact

PyPlot.rc("figure", figsize=(10,4))

include("plotting.jl")

@everywhere using Distributions
@everywhere include("load_data.jl")
@everywhere include("ode_solver.jl")