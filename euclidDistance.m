function rslt = euclidDistance(sol1, sol2)
% measuring the distance between two solutions

rslt = sqrt(sum((sol1(1:6, :) - sol2(1:6, :)).^2, 1));

end