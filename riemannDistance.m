function rslt = riemannDistance(sol1, sol2)
% measuring the length of the geodesic

[m1, n1] = size(sol1);
[m2, n2] = size(sol2);
if m1~=m2 || n1~=n2
    error('incompatible solutions!')
end

% myGeos = cell(n1, 1);
rslt = zeros(n1, 1);

for i = 1:n1
%     myGeos{i} = geodesics(sol1(:, i), sol2(:, i));
    myGeos = geodesics(sol1(:, i), sol2(:, i));
    rslt(i) = myGeos.y(2, end);
end

end