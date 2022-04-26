function rslt = euclidDistance(sol1, sol2)

rslt = sqrt(sum((sol1(1:3, :) - sol2(1:3, :)).^2, 1));

end