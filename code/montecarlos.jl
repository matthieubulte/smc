function MetropolisHastings(K, Π, γ, x₀)
    X = zeros(K, length(x₀))
    Y = zeros(K, length(x₀))
    W = zeros(K)
    accepted = 0
    
    w = MvNormal(γ^2*eye(length(x₀)))
    x = x₀
    πₓ = Π(x)
    
    for k=1:K
        y = x + rand(w)
        πₙ = Π(y)
        if rand() < min(1, πₙ / πₓ)
            x = y
            πₓ = πₙ
            accepted += 1
        end
        
        W[k] = πₙ
        Y[k,:] = y
        X[k,:] = x
    end
    X, Y, W, accepted
end

function noop(n,W,X,A,ESS) 
end


function SequentialMonteCarlo(X₀, p, γ; μ=0.1, progress=noop, n_mcmc_updates=1)
    # initialization
    N,d = size(X₀)
    w = MvNormal(μ^2 * eye(d))

    X = SharedArray{Float64}(X₀)
    dX = zeros(X₀)
    
    W = ones(N)/N
    Wₙ = SharedArray{Float64}(N)
    
    acceptance_rate = zeros(p)
    ess = zeros(p)
    
    
    # initialize
    @sync @parallel for i=1:N
        Wₙ[i] = γ(1, X[i,:])
    end
    W = W.*Wₙ / vecdot(W, Wₙ)
    
    for n = 1:p
        for i=1:n_mcmc_updates
            # update
            dX = rand(w, N)'
            n_accepted = @sync @parallel (+) for i=1:N
                xₙ = X[i,:] + dX[i,:]
                wₙ = γ(n, xₙ)

                accepted = 0
                if rand() < min(1, wₙ / W[i])
                    Wₙ[i] = wₙ
                    X[i,:] = xₙ
                    accepted = 1
                end
                accepted
            end
            acceptance_rate[n] += n_accepted
            
            # normalize weights
            W = W.*Wₙ / vecdot(W, Wₙ)
        end
        acceptance_rate[n] /= N * n_mcmc_updates

        # resample
        ESS = 1 / vecdot(W,W)
        ess[n] = ESS
        if ESS < N/2            
            perm = rand(Categorical(W), N)
            X = X[perm, :]
            Wₙ = Wₙ[perm]
            W = ones(N)/N
        end
        
        progress(n,W,X,acceptance_rate,ess)
    end
    
    W,X,acceptance_rate,ess
end