function [q0, w0, z0] = initializeSmallVariation(z0)

% This method randomly picks a point in TS^2, close to a previous initial point.

q0 = z0(1:3) + 0.1 * rand(3, 1);
q0 = q0/norm(q0, 2); %dividiamo per la norma per make sure che siamo sulla sfera unitaria
v = z0(4:6) + 0.1 * rand(3, 1);
w0 = cross(q0, v);

z0 = [q0; w0];

end
