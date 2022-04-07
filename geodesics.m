function rslt = geodesics(sol1, sol2)
% evaluation of geodesic between q1 and q2

% transformation matrix to rotate the point on an equator
Q = toEquator(sol1(1:3), sol2(1:3));

% rotating the points on the equator
q1 = transpose(Q) * sol1(1:3);
w1 = transpose(Q) * sol1(4:6);
q2 = transpose(Q) * sol2(1:3);
w2 = transpose(Q) * sol2(4:6);

% transform the cartesian coordiantes in spherical
q1 = cart2sph(q1);
w1 = vec2sph(q1, w1);
q2 = cart2sph(q2);
w2 = vec2sph(q2, w2);
% q1 = cart2sph(sol1(1:3));
% w1 = vec2sph(sol1(1:3), sol1(4:6));
% q2 = cart2sph(sol2(1:3));
% w2 = vec2sph(sol2(1:3), sol2(4:6));

% saving the points without the radius component (should be always one)
tol = 1e-13;
if (q1(1) < 1 - tol || q1(1) > 1 + tol) || (q2(1) < 1 - tol || q2(1) > 1 + tol)
    error('solution not on the sphere!')
end
P1 = [q1(2); q1(3); w1(2); w1(3)];
P2 = [q2(2); q2(3); w2(2); w2(3)];
% P1 = [q1(2); q1(3); 0; 0];
% P2 = [q2(2); q2(3); 0; 0];

% definition of the function for the resolution of the geodesics
bvpfun = @(x, y) geodesicEq(x, y);
bcfun = @(ya, yb) bcFun(ya, yb, P1, P2);

xmesh = linspace(0, 1);
solinit = bvpinit(xmesh, zeros(8, 1));

rslt = bvp4c(bvpfun, bcfun, solinit);

end