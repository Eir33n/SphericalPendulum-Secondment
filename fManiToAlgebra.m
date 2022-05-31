function F = fManiToAlgebra(q, w, damp)

% Assembling RHS of the mathematical pendulum
% subject to Earth gravitation [g = 9.81 m/s^2]
% Introducing some damping in the equations

g = 9.81;
e3 = [0; 0; 1];
V = g * cross(e3, q) - damp * w;

F = zeros(6, 1);
F(1:3) = w;
F(4:6) = skw(q) * V;

end