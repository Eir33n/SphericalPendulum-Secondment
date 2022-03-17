function F = fManiToAlgebra(q, w, L, m, damp)

% Assembling RHS of the mathematical pendulum
% subject to Earth gravitation [g = 9.81 m/s^2]
% Introducing some damping in the equations

% TODO : better understand of the damping to make it more physical accurate

V = assembleF(q, w, m, L);

F = zeros(6, 1);
F(1:3) = w;
F(4:6) = V - damp*w;

end