function [q0, w0, z0, v] = initializeSame()

q0 = [1; 0; 0];
v = [0; 0; 0];
w0 = cross(q0, v);

z0 = [q0; w0];

end