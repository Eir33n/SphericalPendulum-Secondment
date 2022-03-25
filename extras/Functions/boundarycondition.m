function res = boundarycondition(q1, q2, p1, p2)
% A function defining the boundary conditions for the geodesics eqns.
% Required by bvp4c

res = zeros(8,1);
res(1:4) = q1(1:4)-p1;
res(5:8) = q2(1:4)-p2;

end