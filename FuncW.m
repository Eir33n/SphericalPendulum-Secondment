function vec = FuncW(z, L, m, damp)

% This function is used to integrate with ODE45, so the input z is of
% the form z = [q1,q2,...,qP,w1,w2,...,wP]
% Builds the part of the vector field for the \dot{w}_i, so
% R(q)^{-1}*right hand side of the ODE, defined by assembleF.
% damp is the damping coeff.

q = z(1:3);
w = z(4:6);

R = m * L^2 * eye(3);
F = assembleF(q, w, m, L) - damp*w;

vec = R\F;

end