# The data is stored in "../data/original_data" as a CSV file in
# which each line contains one run of the experiment and each column
# cᵢ contains the time at which the pendulum reached a 0 angle the ith
# time.
#
# The file was manually edited and cleaned to make automatic processing easier.
#
# Missing data is encoded using the value 0.

filename = "../data/original_data"

# This function loads the data as a one dimensional vector, thus removing structural
# information about the experiments themselves.
# It also filters out missing values, as they don't represent anything anymore.
function load_flat_data()
    X = open(readdlm, filename)[:]
    X[X .!= 0]
end

# This function loads the experiment's data and returns it as a two dimensional array
# together with a null-mask of the same dimension as the data array where
# maskᵢⱼ = 0 if dataᵢⱼ is missing, 1 otherwise 
function load_experiments()
    X = open(readdlm, filename)
    X, abs(sign(X))
end