function sol = jacobianSE3(v, v0, h, f, action)

sol = zeros(6);
sol0 = action(expSE3(h*f(v0)), v0);

for i = 1:6
    dx = v(i)-v0(i);
    if dx ~= 0
        newV = v0;
        newV(i) = v(i);
        k1 = f(newV);
        partialSol = action(expSE3(h*k1), v0);
        sol(:,i) = (partialSol-sol0)/dx;
    end
end

sol = sol-eye(6);

end