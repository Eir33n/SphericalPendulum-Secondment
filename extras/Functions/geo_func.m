function Z1 = geo_func(x, Z)
% This is a wrapper that adapts geodesiceq to the requirements of the scipy solver solve_bvp

(n, m) = shape(Z);
Z1 = zeros(8,'like', Z);
    for k = 1 : m
            Z1(1:k) = geodesiceq( Z(1 : k));
    end


end

