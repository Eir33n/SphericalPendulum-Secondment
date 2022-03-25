function dydx = geo_func(x, y)
% This is a wrapper that adapts geodesiceq to the requirements of the scipy solver solve_bvp

[n, m] = shape(y);
dydx = zeros(8,m);

for k = 1 : m
    dydx(1:k) = geodesiceq(y(1 : k));
end

end