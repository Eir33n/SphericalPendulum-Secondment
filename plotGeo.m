function plotGeo(sols, geo)

% plotTraj(sols)

% Create sphere surface
% [xS2, yS2, zS2] = sphere(360);
% h = surf(xS2, yS2, zS2, 'FaceAlpha', 0.1); 
% h.EdgeColor = 'none';
% hold on

[m, ~] = size(geo);

for i = 1:m
    Q = toEquator(sols{1}(1:3, i), sols{2}(1:3, i));
    geoCurr = geo{i};
    
    [~, n] = size(geoCurr.x);
    cartCoord = zeros(3, n);
    for j = 1:n
        cartCoord(:, j) = sph2cart(geoCurr.y(1:2, j));
        cartCoord(:, j) = Q * cartCoord(:, j);
        plot3(cartCoord(1, j), cartCoord(2, j), cartCoord(3, j), '*k', LineWidth=3);
    end
end

end