%% number of tests

N = 10;

%% METHOD
% method = 1 --> explicit Lie Euler
% method = 2 --> implicit Lie Euler
% method = 3 --> implicit Lie midpoint rule
% method = 4 --> ode45 (MATLAB routine)
% method = 5 --> closes run
% method > 5 --> gives error

method = 3 * ones(1, N);

%% TIME and STEPS
% T = end time of the simulation
% N_TIME = number of steps
T = 1;
N_TIME = logspace(0.01, 3, N);
N_TIME = ceil(N_TIME);

%% system parameters

k = 0;
damp = [1, 5, 10, 50, 100, 500];

%% initial conditions

z0 = [1; 0; 0; 0; 0; 0];

for j = 1:6
for i = 1:N
    main(method(i), N_TIME(i), k, damp(j), z0, T)
    pause(1)
end
end

clearvars
