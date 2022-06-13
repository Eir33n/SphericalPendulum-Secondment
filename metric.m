function G = metric(q)
% The Sasaki metric on TS2 in spherical coordinates

phi     = q(1);
theta   = q(2);
vphi    = q(3);
vtheta  = q(4);
s = sin(phi);
c = cos(phi);

G = zeros(4, 4);
G(1, 1) = 1 + (s * vtheta) ^ 2;
G(1, 2) = s ^ 2 * vphi * vtheta;
G(1, 3) = 0;
G(1, 4) = - c * s * vtheta;
G(2, 1) = s ^ 2 * vphi * vtheta;
G(2, 2) = c ^ 2 * (1 + (s * vtheta) ^ 2) + s ^ 2 * vphi ^ 2;
G(2, 3) = c * s * vtheta;
G(2, 4) = - c * s * vphi;
G(3, 1) = 0;
G(3, 2) = c * s * vtheta;
G(3, 3) = 1;
G(3, 4) = 0;
G(4, 1) = - c * s * vtheta;
G(4, 2) = - c * s * vphi;
G(4, 3) = 0;
G(4, 4) = c ^ 2;

end