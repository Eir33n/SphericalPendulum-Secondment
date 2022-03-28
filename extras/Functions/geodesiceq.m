function dydx = geodesiceq(~, y)
% The second order system for the geodesics in spherical coordinates

Y = y(1:4);
V = y(5:8);
Gamma = Christoffel(Y);
dydx = zeros(8,1);
dydx(1:4) = V;
dydx(5)  = - transpose(V) * reshape(Gamma(1,:,:),[4,4]) * V;
dydx(6)  = - transpose(V) * reshape(Gamma(2,:,:),[4,4]) * V;
dydx(7)  = - transpose(V) * reshape(Gamma(3,:,:),[4,4]) * V;
dydx(8)  = - transpose(V) * reshape(Gamma(4,:,:),[4,4]) * V;

end