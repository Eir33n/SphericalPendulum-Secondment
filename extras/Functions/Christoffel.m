function Gamma = Christoffel(Y)
% The Levi Civita connection on TS2  expressed in spherical coordinates

Y = zeros(1, 4);
Y(1) = phi;
Y(2) = theta;
Y(3) = vphi;
Y(4) = vtheta;
s = sin(phi);
c = cos(phi);
t = tan(phi);

Gamma = zeros(4, 4, 4);
Gamma(1, 1, 2) = - s * c * vtheta * vphi / 2;
Gamma(1, 2, 1) = Gamma(1, 1, 2);
Gamma(1, 2, 2) = -c * s * (c ^ 2 * vtheta ^ 2 + vphi ^ 2 - 1);
Gamma(1, 2, 3) = -c ^ 2 * vtheta / 2 ;
Gamma(1, 3, 2) = Gamma(1, 2, 3);
Gamma(1, 2, 4) = c ^ 2 * vphi / 2;
Gamma(1, 4, 2) = Gamma(1, 2, 4);
Gamma(2, 1, 1) = t * vtheta * vphi;
Gamma(2, 1, 2) = t * (c ^ 2 * vtheta ^ 2 + vphi ^ 2 -2)/2 ;
Gamma(2, 2, 1) = Gamma(2, 1, 2);
Gamma(2, 1, 3) = vtheta / 2;
Gamma(2, 3, 1) = Gamma(2, 1, 3);
Gamma(2, 1, 4) = - vphi / 2 ;
Gamma(2, 4, 1) = Gamma(2, 1, 4);
Gamma(3, 1, 1) = -s ^ 2 * vtheta ^ 2 * vphi;
Gamma(3, 1, 2) = (c ^ 4 * vtheta ^ 2 + (vphi ^ 2 - vtheta ^ 2 + 1 ) * c ^ 2 - vphi ^ 2) * vtheta / 2;
Gamma(3, 2, 1) = Gamma(3, 1, 2);
Gamma(3, 1, 3) = -c * s * vtheta ^ 2 / 2;
Gamma(3, 3, 1) = Gamma(3, 1, 3);
Gamma(3, 1, 4) = s * c * vtheta * vphi / 2;
Gamma(3, 4, 1) = Gamma(3, 1, 4);
Gamma(3, 2, 2) = -s ^ 2 * vphi;
Gamma(3, 2, 4) = c * s;
Gamma(3, 4, 2) = Gamma(3, 2, 4);
Gamma(4, 1, 1) = - vtheta * (c ^ 2 * vphi ^ 2 + c ^ 2 - vphi ^ 2) / c ^ 2;
Gamma(4, 1, 2) = - vphi * ((vphi ^ 2 - 1) * c ^ 2 - vphi ^ 2 + 2) / 2 / c ^ 2;
Gamma(4, 2, 1) = Gamma(4, 1, 2);
Gamma(4, 1, 3) = t * vtheta * vphi / 2;
Gamma(4, 3, 1) = Gamma(4, 1, 3);
Gamma(4, 1, 4) = - s * (vphi ^ 2 + 2) / 2 / c;
Gamma(4, 4, 1) = Gamma(4, 1, 4);
Gamma(4, 2, 2) = - s ^ 2 * vtheta * (c ^ 2 * vtheta ^ 2 + vphi ^ 2);
Gamma(4, 2, 3) = - t * (c ^ 2 * vtheta ^ 2 + 2) / 2 ;
Gamma(4, 3, 2) = Gamma(4, 2, 3);
Gamma(4, 2, 4) = s * vtheta * vphi * c / 2 ;
Gamma(4, 4, 2) = Gamma(4, 2, 4);

end