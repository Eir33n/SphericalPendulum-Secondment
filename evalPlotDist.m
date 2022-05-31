function evalPlotDist(sols, params, same)
% evaluate the distance and plot the solution

sol1 = sols{1};
sol2 = sols{2};

if nargin == 2
    same = false;
end

rDist = riemannianDistance(sols, params);
eDist = euclidDistance(sol1, sol2);
plotDist(rDist, eDist, same)

end