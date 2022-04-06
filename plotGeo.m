function plotGeo(sols, geo)

plotTraj(sols)

% length of geo.y
[~, n] = size(geo.x);
cartCoord = zeros(6, n);
for j = 1:n
    cartCoord(:, j) = sph2vecs(geo.y(:, j));
end

plot3(cartCoord(1, :), cartCoord(2, :), cartCoord(3, :), '-k', LineWidth=3);

end