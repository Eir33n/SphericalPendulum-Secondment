function plotEnergy(sols, damp)

if nargin < 2
    damp = inputdlg('Insert a value for damping:', 'Damping value', [1 40], {'0'});
    damp = str2double(damp{1});
end

prompt = {'Insert mass value'};
dlgtitle = 'Mass value';
definput = {'1'};
dims = [1 40];
M = inputdlg(prompt,dlgtitle,dims,definput);
M = str2double(M{1});

prompt = {'Insert length value'};
dlgtitle = 'Length value';
definput = {'1'};
dims = [1 40];
L = inputdlg(prompt,dlgtitle,dims,definput);
L = str2double(L{1});

% ENERGY EVALUATION
Energy_kinetic = @(q, w) 0.5 * M * cross(w, q)' * cross(w, q) - M * damp * q' * cross(w, q);
Energy_potential = @(q, w) potential(q, L, M);

[m, ~] = size(sols);

for i = 1:m
    qSol = sols{i}(1:3, :);
    wSol = sols{i}(4:6, :);

    [~, n] = size(qSol);
    timeVec = linspace(0, 1, n);
    K = zeros(n, 1);
    P = zeros(n, 1);

    for j = 1:n
        K(j) = Energy_kinetic(qSol(:, j), wSol(:, j));
        P(j) = Energy_potential(qSol(:, j), wSol(:, j));
    end

    figure()
    ax(1) = subplot(2, 1, 1);
    plot(timeVec, (K+P), timeVec, P, timeVec, K, 'LineWidth', 3)
    ylabel('Energy', 'FontSize', 16)
    legend('Total Energy', 'Potential Energy', 'Kinetic Energy')
    grid()
    ax(2) = subplot(2, 1, 2);
    plot(timeVec, (K+P), 'LineWidth', 3)
    ylabel('Total Energy', 'FontSize', 16)
    grid()
    linkaxes(ax,'x');
    xlabel('Time', 'FontSize', 16)
    sgtitle("Energy of the system "+num2str(i), 'FontSize', 18)

end

end