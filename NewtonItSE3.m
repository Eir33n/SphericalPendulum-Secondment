function sol = NewtonItSE3(residual, jacobian, p, h, max_it, tol)
    
    pNew = p;
    
    for i = 1:max_it
        sol = residual(p, pNew, h);

        res = -pNew + sol;
        if norm(res) < tol
%             disp(i)
            break
        end

        S_t = jacobian(pNew, p, h);
        dx = -S_t\res;
    
        pNew = pNew + dx;
    end

    if i == max_it
        disp('not converged!')
    end

end