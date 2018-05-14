using PyPlot
using Interact

PyPlot.rc("figure", figsize=(10,8))

include("plotting.jl")

@everywhere using Distributions
@everywhere using ODE
@everywhere include("load_data.jl")
