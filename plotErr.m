function plotErr(error)
absErrq = cell2mat(error(1,:));
absErrw = cell2mat(error(2,:));
relErrq = cell2mat(error(3,:));
relErrw = cell2mat(error(4,:));

figure()
subplot(2, 1, 1)
loglog([1e-2; 1e-3; 1e-4; 1e-5], absErrq, '-or', 'LineWidth', 3)
hold on
loglog([1e-2; 1e-3; 1e-4; 1e-5], absErrw, '-ob', 'LineWidth', 3)
legend('error on q', 'error on w')
xlabel('time step size', 'FontSize', 16)
ylabel('absolute error', 'FontSize', 16)
title('Absolute error over time step size', 'FontSize', 16)
grid('on')

subplot(2, 1, 2)
loglog([1e-2; 1e-3; 1e-4; 1e-5], relErrq, '-or', 'LineWidth', 3)
hold on
loglog([1e-2; 1e-3; 1e-4; 1e-5], relErrw, '-ob', 'LineWidth', 3)
legend('error on q', 'error on w')
xlabel('time step size', 'FontSize', 16)
ylabel('relative error', 'FontSize', 16)
title('Relative error over time step size', 'FontSize', 16)
grid('on')

end