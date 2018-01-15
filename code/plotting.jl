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

function plotSMC(output; binwidth=0.01)
    W,X,A,ESS = output
    Y = round.(X/binwidth)
    mini = minimum(Y)

    m = convert(Int32,maximum(Y) - mini + 1)
    ws = zeros(m)

    for i=1:length(W)
        ws[convert(Int32,Y[i]-mini+1)]+=W[i]
    end

    maxW = maximum(ws)
    g = vecdot(W,X)    

    clf()
    
    subplot(221)
    title("dμʸ / dμ₀ (expectation estimation = $(round(vecdot(X,W)*1000)/1000))")
    ylim(0,maxW*1.1)
    xlim(minimum(X)-2*binwidth,maximum(X)+2*binwidth)
    bar((collect(1:m) + mini - 1)*binwidth, ws, width=binwidth)
    plot([g; g], [0; maxW*1.1], "r--")
    
    subplot(223)
    title("Acceptance rate (mean = $(round(mean(A) * 100)/100))")
    plot(1:length(A), A)
    plot(1:length(A), ones(A)*A[end], "r--")
    
    subplot(224)
    title("ESS (mean = $(round(mean(ESS))))")
    plot(1:length(ESS), ESS)
    plot(1:length(ESS), ones(ESS)*ESS[end], "r--")
end