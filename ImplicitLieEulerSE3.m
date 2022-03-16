function sol = ImplicitLieEulerSE3(vecField, action, p, h, max_it, tol)
    
    pNew = p;
    
    for i = 1:max_it
        k1 = vecField(pNew);
        sol = action(expSE3(h*k1), p);
    
        res = -pNew + sol;
        if norm(res) < tol
%             disp(i)
            break
        end

        S_t = jacobianSE3(pNew, p, h, vecField, action);
        dx = -S_t\res;
    
        pNew = pNew + dx;
    end

    if i == max_it
        disp('not converged!')
    end

end