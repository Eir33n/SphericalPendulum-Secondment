function sol = residualSE3(v0, v, h, f, action, method)

switch method
    case 1
        sol = action(expSE3(h*f(v)), v0);
    case 2
        sol = action(expSE3(h*f((v+v0)/2)), v0);
    case 3
        sol = action(expSE3(h/2*(f(v)+f(v0))), v0);
    otherwise
        error('Method not implemented!')
end

end

