function plotGeo(sols, geo)
% Plot of the geodesics or
% plot of an easy example

if nargin < 1
    q1 = [1; 0; 0; 0; 0; 0];
    q2 = [sqrt(2)/2; sqrt(2)/2; 0; 0; 0; 0];
    geoEx = geodesics(q1, q2);

    [~, n] = size(geoEx.x);
    cartCoord = zeros(3, n);
    for k = 1:n
        cartCoord(:, k) = sph2cart(geoEx.y(1:2, k));
    end
    % Create sphere surface
    [xS2, yS2, zS2] = sphere(100);
    h = surf(xS2, yS2, zS2, 'FaceAlpha', 0.1); 
    h.EdgeColor = 'k';
    h.LineStyle = ':';
    hold on
    plot3(cartCoord(1, :), cartCoord(2, :), cartCoord(3, :), '-r', ...
                                                   'LineWidth', 3)
    plot3([0, q1(1)], [0 q1(2)], [0, q1(3)], '-k', 'LineWidth', 3)
    plot3([0, q2(1)], [0 q2(2)], [0, q2(3)], '-k', 'LineWidth', 3)
else
    plotTraj(sols)
    
%     Create sphere surface
%     [xS2, yS2, zS2] = sphere(360);
%     h = surf(xS2, yS2, zS2, 'FaceAlpha', 0.1); 
%     h.EdgeColor = 'none';
%     hold on
    
    [m, ~] = size(geo);
    
    for i = 1:m
        Q = toEquator(sols{1}(1:3, i), sols{2}(1:3, i));
        geoCurr = geo{i};
        
        [~, n] = size(geoCurr.x);
        cartCoord = zeros(3, n);
        for j = 1:n
            cartCoord(:, j) = sph2cart(geoCurr.y(1:2, j));
            cartCoord(:, j) = Q * cartCoord(:, j);
        end
        plot3(cartCoord(1, :), cartCoord(2, :), cartCoord(3, :), '-k', ...
                                                       'LineWidth', 3)
    end
end

end