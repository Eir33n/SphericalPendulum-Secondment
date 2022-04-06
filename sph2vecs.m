function rslt = sph2vecs(q)
% Funtion from spherical coordinates to cartesian coordinate on TS2

if size(q, 1) == 4
    q = [1, q(1), q(2), 0, q(3), q(4)];
end

rslt = zeros(6, 1);

rslt(1:3) = sph2cart(q(1:3));

A = [cos(q(2))*cos(q(3)), -q(1)*sin(q(2))*cos(q(3)),   -q(1)*cos(q(2))*sin(q(3));
     cos(q(2))*sin(q(3)), -q(1)*sin(q(2))*sin(q(3)),    q(1)*cos(q(2))*cos(q(3));
               sin(q(2)),            q(1)*cos(q(2)),                          0];
rslt(4:6) = A*q(4:6);

end