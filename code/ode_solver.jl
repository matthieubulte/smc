function rk4(f, x, τ)
    k = f(x)

    ψ = k

    k = f(x + τ*.5k)
    ψ += 2k

    k = f(x + τ*.5k)
    ψ += 2k

    k = f(x + τ*k)
    ψ += k

    x + τ*(1/6)*ψ
end

function rk4s!(B, f, x, ts, τ)
    t = ts[1]
    for it = 1:length(ts)
        while abs(t - ts[it]) > 1e-8
            t += min(ts[it], t+τ)-t
            x = rk4(f, x, τ)
        end
        t = ts[it]

        B[it,:] = x
    end
end

function rk4s(f, x, ts, τ)
    B = zeros(length(ts), length(x))
    rk4s!(B, f, x, ts, τ)
    B
end