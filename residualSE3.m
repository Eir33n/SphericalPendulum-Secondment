function sol = residualSE3(v0, v, h, f, action, method)

% RHS of the system
% the action on Lie groups allows us to remain on the manifold

switch method
    case 1
        % Implicit Lie Euler
        sol = action(expSE3(h*f(v)), v0);
    case 2
        % Implicit Midpoint Rule
        sol = action(expSE3(h*f((v+v0)/2)), v0);
    case 3
        % Trapezoidal Rule
        sol = action(expSE3(h/2*(f(v)+f(v0))), v0);
    otherwise
        error('Method not implemented!')
end

end

