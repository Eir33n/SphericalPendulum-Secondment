function Zd = geodesiceq(Z)
% The second order system for the geodesics in spherical coordinates

Y = Z(1:4);
V = Z(5:8);
Gamma = Christoffel(Y);
Zd = zeros(8,1);
Zd(1:4) = V;
Zd(5)  = - transpose(V) * Gamma(1,:,:) * V;
Zd(6)  = - transpose(V) * Gamma(2,:,:) * V;
Zd(7)  = - transpose(V) * Gamma(3,:,:) * V;
Zd(8)  = - transpose(V) * Gamma(4,:,:) * V;

end