function plotNorm(sols, params)

[m, ~] = size(sols);

for i = 1:m
    qnorm = zeros(params{i}.N_TIME, 1);  
    ortho = zeros(params{i}.N_TIME, 1);  
    for t = 1:params{i}.N_TIME
        qnorm(t) = norm(sols{i}(1:3, t)) - 1;
        ortho(t) = sols{i}(3+(1:3), t)' * sols{i}(1:3, t);
    end
    figure()
    ax(1) = subplot(1, 2, 1);
    plot(params{i}.time, qnorm, 'r-', 'LineWidth', 3)
    grid on
    xlabel('time', 'FontSize', 16)
    ylabel('$\|q\|_2 - 1$', 'Interpreter', 'latex', 'FontSize', 16)
    title('2-Norm of the solution $q$', 'Interpreter', 'latex', 'FontSize', 18)
    ax(2) = subplot(1, 2, 2);
    plot(params{i}.time, ortho, 'b-', 'LineWidth', 3)
    grid on
    xlabel('time', 'FontSize', 16)
    ylabel('$w^{\top}q$', 'Interpreter', 'latex', 'FontSize', 16)
    title('Solution in TS$^2$', 'Interpreter', 'latex', 'FontSize', 18)
    sgtitle('Solution with '+params{i}.my_method, 'FontSize', 18)
%     linkaxes(ax, 'y');
end
end