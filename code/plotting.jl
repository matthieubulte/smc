function plotMCMC(output)
    X, Y, W, accepted = output
    
    subplot(121)
    title("pdf")
    PyPlot.plt[:hist](X, 40)

    subplot(122)
    title("g")
    scatter(1:length(X), X, s=0.1)
    
    println(
        "$(accepted) / $(length(X)) of the sampled particles were accepted ($(round(accepted/length(X) * 100))%)
        \nThe expectation estimation is of $(mean(X))"
    );
end

function plotSMC(output)
    W,X,A,ESS,M,V = output
    
    t = 1:length(A)
    
    subplot(221)
    title("dμʸ / dμ₀ (expectation estimation = $(round(vecdot(X,W)*1000)/1000))")
    PyPlot.plt[:hist](X, 40, weights=W)
    
    subplot(222)
    plot(t, M, linewidth=.5,color="black")
    fill_between(t, M-V, M+V, alpha=0.5, color="lightgrey")
    
    subplot(223)
    title("Acceptance rate (mean = $(round(mean(A) * 100)/100))")
    plot(t, A)
    plot(t, ones(A)*A[end], "r--")
    
    subplot(224)
    title("ESS (mean = $(round(mean(ESS))))")
    plot(t, ESS)
    plot(t, ones(ESS)*ESS[end], "r--");
end