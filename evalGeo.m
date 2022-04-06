function rslt = evalGeo(sol1, sol2)

[m1, n1] = size(sol1);
[m2, n2] = size(sol2);
if m1~=m2 || n1~=n2
    error('incompatible solutions!')
end

rslt = cell(n1, 1);

for i = 1:n1
    rslt{i} = geodesics(sol1(:, i), sol2(:, i));
end

end