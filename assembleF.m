function F = assembleF(~, ~)

% This function defines the right hand side, precisely we need it to define the equations for
% the angular velocities, which now becomes R(q)w' = F, and here we assemble this F vector.

g = 9.81;
e3 = [0; 0; 1];

F = - g * e3;

end