function [q0, w0, z0] = initializeSmallVariation(z0, both)
% This method randomly picks a point in TS^2, close to a previous initial point.

% Initial position close to previous position
q0 = z0(1:3) + 0.01 * rand(3, 1);
q0 = q0/norm(q0, 2); % Normalize to remain on the unit sphere
if nargin > 1
    if both
        % Angular velocity close to the previous one
        v = cross(z0(4:6), z0(1:3)) + 0.01 * rand(3, 1);
        w0 = cross(q0, v);
    else
        w0 = (eye(3) - q0*q0') * z0(4:6);
    end
else
    w0 = (eye(3) - q0*q0') * z0(4:6);
end

z0 = [q0; w0];

end
