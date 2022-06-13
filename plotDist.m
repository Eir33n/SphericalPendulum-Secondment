function plotDist(rDist, eDist, params, same)

if nargin < 4
    same = false;
end

time = linspace(params{1}.t0, params{1}.T, params{1}.N_TIME);

if same
    subplot(2,1,1)
    plot(time, rDist, 'b-', 'LineWidth', 3)
    title('Riemaniann Distance', 'FontSize', 16)
    xlabel('time in s', 'FontSize', 16)
    ylabel('distance in m', 'FontSize', 16)
    grid on
    subplot(2,1,2)
    plot(time, eDist, 'r-', 'LineWidth', 3)
    title('Euclidean Distance', 'FontSize', 16)
    xlabel('time in s', 'FontSize', 16)
    ylabel('distance in m', 'FontSize', 16)
    grid on
else
    plot(time, rDist, 'b-', 'LineWidth', 3, 'DisplayName', 'Riemaniann Distance')
    hold on
    plot(time, eDist, 'r-', 'LineWidth', 3, 'DisplayName', 'Euclidean Distance')
    xlabel('time in s', 'FontSize', 16)
    ylabel('distance in m', 'FontSize', 16)
    grid on
    legend('show')
end

end