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