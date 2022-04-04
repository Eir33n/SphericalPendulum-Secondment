function rslt = vec2sph(q, w)
% Funtion from cartesian coordinate on TS2 to spherical coordinates

sph = cart2sph(q);
A = [cos(sph(2))*cos(sph(3)), -sin(sph(2))*cos(sph(3)), -cos(sph(2))*sin(sph(3));
     cos(sph(2))*sin(sph(3)), -sin(sph(2))*sin(sph(3)),  cos(sph(2))*cos(sph(3));
                 sin(sph(2)),              cos(sph(2)),                        0];
rslt = A\w;

end