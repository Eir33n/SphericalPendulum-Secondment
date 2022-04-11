function [q0, w0, z0, v] = initializeSE3()

% This method randomly picks a point in TS^2.

q0 = rand(3, 1);
q0(3) = -q0(3);
q0 = q0/norm(q0, 2); %dividiamo per la norma per make sure che siamo sulla sfera unitaria
v = rand(3, 1);
w0 = cross(q0, v);

z0 = [q0; w0];

end
