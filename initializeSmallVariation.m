function [q0, w0, z0] = initializeSmallVariation(z0, v)

% This method randomly picks a point in TS^2, close to a previous initial point.

% Initial position close to previous position
q0 = z0(1:3) + 0.01 * rand(3, 1);
q0 = q0/norm(q0, 2); % Normalize to remain on the unit sphere
% Angular velocity close to the previous one
% v = z0(4:6) + 0.1 * rand(3, 1);
w0 = cross(q0, v);

z0 = [q0; w0];

end
