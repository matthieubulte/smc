function plotMCMC(output)
    X, Y, W, accepted = output
    
    subplot(221)
    title("dμʸ / dμ₀")
    PyPlot.plt[:hist](X, 40)

    subplot(222)
    title("xᵢ")
    scatter(1:length(X), X, s=0.1)

    subplot(223)
    title("K(xᵢ₊₁, xᵢ)")
    scatter(1:(length(W)-1), min(1, W[2:end] ./ W[1:end-1]), s=0.1)

    subplot(224)
    title("dμʸ / dμ₀(xᵢ)")
    WW = W/sum(W)
    
    ylim(minimum(WW)*0.95, maximum(WW)*1.05)
    scatter(1:length(W), WW, s=0.1)
    
    println(
        "$(accepted) / $(length(X)) of the sampled particles were accepted ($(round(accepted/length(X) * 100))%)
        \nThe mean estimation is of $(mean(X))"
    );
end

function plotSMC(output; binwidth=0.01)
    W,X = output
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
    ylim(0,maxW*1.1)
    xlim(8,10)

    bar((collect(1:m) + mini - 1)*binwidth, ws, width=binwidth)

    plot([g; g], [0; maxW*1.1], "r--");
end