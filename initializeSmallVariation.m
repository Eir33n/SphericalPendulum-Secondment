function [q0, w0, z0] = initializeSmallVariation(z0, both, rate)
% This method randomly picks a point in TS^2, close to a previous initial point.

if nargin < 3
    rate = 0.01;
end

% Initial position close to previous position
% q0 = z0(1:3) + rate * rand(3, 1);
% q0 = q0/norm(q0, 2); % Normalize to remain on the unit sphere

q0 = zeros(3, 1);
q0(2) = z0(2) + rate * rand(1, 1);
q0(1) = sqrt(1-z0(3)^2-q0(2)^2);
q0(3) = z0(3);
if nargin > 1
    if both
        % Angular velocity close to the previous one
        v = cross(z0(4:6), z0(1:3)) + rate * rand(3, 1);
        w0 = cross(q0, v);
    else
        w0 = (eye(3) - q0*q0') * z0(4:6);
    end
else
    w0 = (eye(3) - q0*q0') * z0(4:6);
end

z0 = [q0; w0];

end
