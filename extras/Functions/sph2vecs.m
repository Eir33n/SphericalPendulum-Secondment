function [q, v] = sph2vecs(Y)
% Transform the spherical coordinates on TS2 to cartesian coordinates

x,y,z = sph2cart(Y(2), Y(1), 1);
q = [x; y; z];
sp = sin(Y(1));
cp = cos(Y(1));
st = sin(Y(2));
ct = cos(Y(2));
v = [- sp * ct * Y(3) - cp * st * Y(4); - sp * st * Y(3) + cp * ct * Y(4); cp * Y(3)];
end