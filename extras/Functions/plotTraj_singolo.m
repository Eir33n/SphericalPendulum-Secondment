function plotTraj_singolo(sol, upto)
% plot the trajectories of spherical pendulum solutions

% Create sphere surface
[xS2, yS2, zS2] = sphere(360);
h = surf(xS2, yS2, zS2, 'FaceAlpha', 0.1); 
h.EdgeColor = 'none';
hold on

plot3(0, 0, 0, 'ro', 'MarkerSize', 3)
[~, m] = size(sol);
myColor = colormap("hsv");

if nargin < 2
    upto = m;
end
q = sol(1:3, :);
j = 0;
n=200;
ind = fix(256 * n / upto);
for i = 1:n:upto
    j = j + 1;
    plot3([0, q(1,i)], [0, q(2,i)], [0, q(3,i)], 'go-', 'MarkerSize', 3, ...
        'MarkerEdgeColor', 'none', ...
        LineWidth=3, ...
        Color=myColor(j*ind, :))
    if i > 1
        plot3([q(1, i-n), q(1,i)], [q(2, i-n), q(2,i)], [q(3, i-n), q(3,i)], 'r-', LineWidth=1.5)
    end
end

end