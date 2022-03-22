function [Result,L] = geodesic_bvp( Y0, Y1, N)
% This function calculates the geodesic that connects two points on TS2 for the Sasaki metric in spherical coords
% It also calculates the distance between the points

x = linspace(0, 1, N);
ZZ = zeros(8, N);
YY = [Y0; Y1] * [(1-x)'; x'];
ZZ(1 : 4, 1 : N) = YY;
boundarycondition.Y0 = Y0;
boundarycondition.Y1 = Y1;
Result = bvp4c(geo_func, boundarycondition, x, ZZ);
L = 0;
m = Result.x.size - 1;
s = Result.x;
Z = Result.y;
for k = 1:m
    Vm = 0.5 * (Z(5 : 8, k) + Z(5 : 8, k + 1))
    Ym = 0.5 * (Z(1 : 4, k) + Z(1 : 4, k + 1))
    L = L + (s(k + 1) - s(k)) * sqrt(transpose(vm) * metric(Ym) * Vm);

end


 