function plotTraj(sols, upto)
% plot the trajectories of spherical pendulum solutions

% Create sphere surface
[xS2, yS2, zS2] = sphere(360);
h = surf(xS2, yS2, zS2, 'FaceAlpha', 0.1); 
h.EdgeColor = 'none';
hold on

[m, ~] = size(sols);
myColor = colormap("hsv");
ind = fix(256 / m);

for i = 1:m
    q = sols{i}(1:3, :);

    [~, n] = size(q);
    if nargin < 2
        upto = n;
    end

    x = linspace(0, 1, upto);
    for j = 1:upto
        plot3(q(1, j), q(2, j), q(3, j), 'o', 'MarkerSize', 3, ...
            'MarkerFaceColor', x(end-(j-1)).*myColor(i*ind, :), ...
            'MarkerEdgeColor', 'none')
    end
end

end