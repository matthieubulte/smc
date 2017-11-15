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

function noop(n,W,X) 
end

function SequentialMonteCarlo(X₀, p, γ; μ=0.1, progress=noop)
    # initialization
    N,d = size(X₀)
    w = MvNormal(μ^2 * eye(d))

    X = X₀
    W = ones(N)/N
    Wₙ = SharedArray{Float64}(N)
    
    @sync @parallel for i=1:N
        Wₙ[i] = γ(1, X[i,:])
    end
    W = W.*Wₙ / vecdot(W, Wₙ)
    progress(1,W,X)
    
    for n = 2:p
        # resampling
        if 1 / vecdot(W,W) < N/2
            X = X[rand(Categorical(W), N), :]
            W = ones(N)/N
        end

        X += rand(w, N)'
        
        @sync @parallel for i=1:N
            Wₙ[i] = γ(n, X[i,:])
        end
        W = W.*Wₙ / vecdot(W, Wₙ)
        progress(n,W,X)
    end
    
    W,X
end