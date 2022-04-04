function gamma = christoffelSymb(q)
% The Levi Civita connection on TS2  expressed in spherical coordinates

phi     = q(1);
theta   = q(2);
vphi    = q(3);
vtheta  = q(4);
s = sin(phi);
c = cos(phi);
t = tan(phi);

gamma = zeros(4, 4, 4);
gamma(1, 1, 2) = - s * c * vtheta * vphi / 2;
gamma(1, 2, 1) = gamma(1, 1, 2);
gamma(1, 2, 2) = -c * s * (c ^ 2 * vtheta ^ 2 + vphi ^ 2 - 1);
gamma(1, 2, 3) = -c ^ 2 * vtheta / 2 ;
gamma(1, 3, 2) = gamma(1, 2, 3);
gamma(1, 2, 4) = c ^ 2 * vphi / 2;
gamma(1, 4, 2) = gamma(1, 2, 4);
gamma(2, 1, 1) = t * vtheta * vphi;
gamma(2, 1, 2) = t * (c ^ 2 * vtheta ^ 2 + vphi ^ 2 -2)/2 ;
gamma(2, 2, 1) = gamma(2, 1, 2);
gamma(2, 1, 3) = vtheta / 2;
gamma(2, 3, 1) = gamma(2, 1, 3);
gamma(2, 1, 4) = - vphi / 2 ;
gamma(2, 4, 1) = gamma(2, 1, 4);
gamma(3, 1, 1) = -s ^ 2 * vtheta ^ 2 * vphi;
gamma(3, 1, 2) = (c ^ 4 * vtheta ^ 2 + (vphi ^ 2 - vtheta ^ 2 + 1 ) * c ^ 2 - vphi ^ 2) * vtheta / 2;
gamma(3, 2, 1) = gamma(3, 1, 2);
gamma(3, 1, 3) = -c * s * vtheta ^ 2 / 2;
gamma(3, 3, 1) = gamma(3, 1, 3);
gamma(3, 1, 4) = s * c * vtheta * vphi / 2;
gamma(3, 4, 1) = gamma(3, 1, 4);
gamma(3, 2, 2) = -s ^ 2 * vphi;
gamma(3, 2, 4) = c * s;
gamma(3, 4, 2) = gamma(3, 2, 4);
gamma(4, 1, 1) = - vtheta * (c ^ 2 * vphi ^ 2 + c ^ 2 - vphi ^ 2) / c ^ 2;
gamma(4, 1, 2) = - vphi * ((vphi ^ 2 - 1) * c ^ 2 - vphi ^ 2 + 2) / 2 / c ^ 2;
gamma(4, 2, 1) = gamma(4, 1, 2);
gamma(4, 1, 3) = t * vtheta * vphi / 2;
gamma(4, 3, 1) = gamma(4, 1, 3);
gamma(4, 1, 4) = - s * (vphi ^ 2 + 2) / 2 / c;
gamma(4, 4, 1) = gamma(4, 1, 4);
gamma(4, 2, 2) = - s ^ 2 * vtheta * (c ^ 2 * vtheta ^ 2 + vphi ^ 2);
gamma(4, 2, 3) = - t * (c ^ 2 * vtheta ^ 2 + 2) / 2 ;
gamma(4, 3, 2) = gamma(4, 2, 3);
gamma(4, 2, 4) = s * vtheta * vphi * c / 2 ;
gamma(4, 4, 2) = gamma(4, 2, 4);

end