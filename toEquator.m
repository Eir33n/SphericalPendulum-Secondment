function rslt = toEquator(q1, q2)
% new reference system - equator passing in q1 and q2
% rslt = Rotation Matrix

[m1, n1] = size(q1);
[m2, n2] = size(q2);

if m1 ~= 3 || m2 ~= 3
    error('two vectors of length 3 required!')
elseif n1 ~= 1 || n2 ~= 1
    error('two column vectors required!')
end

crossProd = cross(q1, q2);
ez = crossProd / norm(crossProd, 2);
ex = q1;
ey = cross(ez, ex);

rslt = [ex, ey, ez];

end