function val = potential(q, L, m)

% Potential energy of a pendulum
% subject to Earth gravity [g = 9.81 m/s^2]
% with fix end in [0, 0, 0]

g = 9.81;
e3 = [0; 0; 1];

val = L * g * m * e3' * q +L * g * m;

end