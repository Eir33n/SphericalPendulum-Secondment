function plotStab(~, param, err)

[n, ~] = size(err);
err_list = zeros(n, 1);
damp_list = zeros(n, 1);
dStep_list = zeros(n, 1);

tol = 0.5;

for i = 1:n
    m = err{i}.info(1);
    ind = err{i}.info(2);
    param_list = param((i-1) * m + 1 : i * m);
    param_list = param_list(setdiff(1:end,ind));
    crr_err = err{i}.q_abserr;
    index = size(crr_err, 2) - 1;
    trend = (log10(crr_err(index)) - log10(crr_err(index+1)));
    order = (log10(err{i}.steps(index)) - log10(err{i}.steps(index+1)));
    conv = trend / order;
    conv_old = conv;
    while abs(conv-conv_old) < tol && index > 1 && crr_err(index) < 5e-1
        index = index - 1;
        trend = (log10(crr_err(index)) - log10(crr_err(index+1)));
        order = (log10(err{i}.steps(index)) - log10(err{i}.steps(index+1)));
        conv_old = conv;
        conv = trend / order;
    end
%     error = err{i}.q_abserr(index_list);
%     param_list = param_list(index_list);
    err_list(i) = err{i}.q_abserr(index);
    damp_list(i) = param_list{index}.damp;
    dStep_list(i) = param_list{index}.dt;
end

[damp_list, index_list] = sort(damp_list);
dStep_list = dStep_list(index_list);
err_list = err_list(index_list);

figure()
yyaxis left
plot(dStep_list, '-ob', 'LineWidth', 1.5);
grid on
xticks(1:length(damp_list))
xticklabels(damp_list)
title('Stability of Explicit Lie Euler', 'FontSize', 16)
xlabel('Damping', 'FontSize', 14)
ylabel('Time step size', 'FontSize', 14)

yyaxis right
plot(err_list, '-*r', 'LineWidth', 1.5);
ylabel('Absolute error')


end