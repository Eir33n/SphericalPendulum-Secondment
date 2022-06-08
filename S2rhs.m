function y = S2rhs(y, damp, k)
% gravitational acceleration
ggrav = 9.81;
% position and velocity
q = y(1:3);
w = y(3+(1:3));
% right hand side of the system
y(1:3) = cross(w, q);
y(3+(1:3)) = ggrav * cross ( [0,0,1]', q ) - damp * om + k * (om'*q) * q;
end