%% number of tests

N = 10;

%% METHOD
% method = 1 --> explicit Lie Euler
% method = 2 --> implicit Lie Euler
% method = 3 --> implicit Lie midpoint rule
% method = 4 --> ode45 (MATLAB routine)
% method = 5 --> closes run
% method > 5 --> gives error

method = 1 * ones(1, N);

%% TIME and STEPS
% T = end time of the simulation
% N_TIME = number of steps
T = 1;
% N_TIME = 1e6 * ones(1, N);
% T = 1;
N_TIME = logspace(0.01, 3, N);
N_TIME = ceil(N_TIME);
% N_TIME(end+1) = 1e6;

%% system parameters

k = 0;
damp = linspace(10, 1000, N-5);

%% initial conditions

% [~, ~, z0(:, 1)] = initializeZeroVel();
% [~, ~, z0(:, 2)] = initializeSmallVariation(z0(:, 1));
z0 = startingValue();

for j = 1:N-5
for i = 1:N
    main(method(i), N_TIME(i), k, damp(j), z0, T)
    pause(1)
end
end

clearvars
