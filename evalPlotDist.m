function evalPlotDist(sol1, sol2, geo, same)
% evaluate the distance and plot the solution

if nargin == 2
    same = false;
    rDist = riemannDistance(sol1, sol2);
    eDist = euclidDistance(sol1, sol2);
elseif nargin == 3
    same = false;
    rDist = riemannDistance(sol1, sol2, geo);
    eDist = euclidDistance(sol1, sol2);
else
    rDist = riemannDistance(sol1, sol2, geo);
    eDist = euclidDistance(sol1, sol2);
end

plotDist(rDist, eDist, same)

end