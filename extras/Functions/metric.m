function G = metric(Y)
% The Sasaki metric on TS2 in spherical coordinates
G = zeros(4);
Y = zeros(1,4);
Y(1) = phi;
Y(2) = theta;
Y(3) = vphi;
Y(4) = vtheta;
s = sin(phi);
c = cos(phi);
g11 = 1 + (s*vtheta)^2;

G = [g11, s^2*vphi*vtheta, 0, -c*s*vtheta;
     s^2*vphi*vtheta, c^2*g11+s^2*vphi^2, c*s*vtheta, -c*s*vphi;
     0, c*s*vtheta, 1, 0;
     -c*s*vtheta, -c*s*vphi, 0, c^2];

end