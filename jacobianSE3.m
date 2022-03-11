function sol = jacobianSE3(v, h, m, L, damp)

g = 9.81;

dA = zeros(6);
dA(1:3, 1:3) = hat(v(4:6));
dA(1:3, 4:6) = -hat(v(1:3));
dA(4:6, 1:3) = [-2*v(1)*v(2),   -3*v(2)^2, -2*v(2)*v(3); ...
                    3*v(1)^2, 2*v(1)*v(2),  2*v(1)*v(3); ...
                           0,           0,            0] * (g/L);
if damp ~= 0
    dA(4:6, 4:6) = -damp / (m*L^2) * eye(3);
end


sol = -eye(6) + h * dA * v;

end