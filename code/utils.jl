function indicator(min, max)
    x -> (x >= min && x <= max) ? 1 : 0
end

function dunif(min, max)
    I = indicator(min, max)
    x -> I(x) / (max-min)
end

function dunif2(area)
    u1 = dunif(area[1,1], area[1,2])
    u2 = dunif(area[2,1], area[2,2])
    
    x -> u1(x[1])*u2(x[2])
end

function dnorm(mu, var)
    x -> exp(-(x-mu)^2/(2var))/sqrt(2*pi*var)
end

function contour2d(f, coords, n)
    x = linspace(coords[1,1], coords[1,2],n)
    y = linspace(coords[2,1], coords[2,2],n)

    xgrid = repmat(x',n,1)
    ygrid = repmat(y,1,n)

    z = zeros(n,n)
    for i in 1:n
        for j in 1:n
            z[i:i,j:j] = f([x[i] y[j]])
        end
    end

    contour(xgrid,ygrid,z)
end

function foldi(f, acc, upto)
    for i = 1:upto
        acc = f(i, acc)
    end
    acc
end

function sumoveri(f, upto)
    acc = 0
    for i = 1:upto
        acc += f(i)
    end
    acc
end

function quad2(f)
    k35 = sqrt(3/5)
    k89 = 8/9
    k59 = 5/9
    
    k59^2*(f(-k35,-k35) + f(k35,-k35) + f(-k35, k35) + f(k35,k35)) +
    k89^2*f(0,0) + 
    k89*k59*(f(0,-k35) + f(-k35,0) + f(k35,0) + f(0,k35))
end