function rslt = expMap(p, u)
% exponential map on S2
% given a point on S2 --> p
% and its velocity --> u
% expMap evaluates gamma(1),
% where gamma(t) is the geodesic with initial conditions
% gamma(0) = p; dot{gamma}(0) = u

theta = norm(u);

if theta < 1e-12
    rslt = p;
else
    rslt = cos(theta) * p + sin(theta) / theta * u;
    rslt = rslt / norm(rslt);
end

end