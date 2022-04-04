function dydx = geodesicEq(~, y)
% The second order system for the geodesics in spherical coordinates

q = y(1:4);
v = y(5:8);
gamma = christoffelSymb(q);
dydx = zeros(8,1);
dydx(1:4) = v;
dydx(5)  = - transpose(v) * reshape(gamma(1,:,:),[4,4]) * v;
dydx(6)  = - transpose(v) * reshape(gamma(2,:,:),[4,4]) * v;
dydx(7)  = - transpose(v) * reshape(gamma(3,:,:),[4,4]) * v;
dydx(8)  = - transpose(v) * reshape(gamma(4,:,:),[4,4]) * v;

end