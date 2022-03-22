function [x, y, z] = sph2cart(az, el, r)
% Transform spherical coordinates to cartesian coordinates on S2

rcos_theta = r * cos(el);
x = rcos_theta * cos(az);
y = rcos_theta * sin(az);
z = r * sin(el);

end