function rslt = riemannDistance(sol1, sol2, geo)
% measuring the length of the geodesic

calculate_geodesic = false;
if nargin < 3
    calculate_geodesic = true;
end

[m1, n1] = size(sol1);
[m2, n2] = size(sol2);
if m1~=m2 || n1~=n2
    error('incompatible solutions!')
end

rslt = zeros(n1, 1);

for i = 1:n1
    if calculate_geodesic
        myGeos = geodesics(sol1(:, i), sol2(:, i));
    else
        myGeos = geo{i};
    end

    for j = 1:size(myGeos.yp, 2)
        rslt(i) = rslt(i) + norm(myGeos.yp(1:4, j), 2);
    end
    rslt(i) = rslt(i) * (myGeos.x(end)-myGeos.x(1)) / size(myGeos.yp, 2);
end

end