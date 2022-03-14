function sol = LieEulerSE3(vecField, action, p, h)

    %Computes one time step update with Lie Euler 

    k1 = vecField(p);

    sol = action(expSE3(h*k1), p); 
    
end