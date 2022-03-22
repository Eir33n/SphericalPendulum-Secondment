function R = boundarycondition(Za, Zb)
% A function defining the boundary conditions for the geodesics eqns. Required by solve_bvp

R = zeros(8,1);
R(1 : 4) = Za(1 : 4) - boundarycondition.Y0;
R(5 : 8) = Zb(5 : 8) - boundarycondition.Y1;
end

