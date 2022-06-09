%% number of tests

N = 4;

%% METHOD
% method = 1 --> explicit Lie Euler
% method = 2 --> implicit Lie Euler
% method = 3 --> implicit Lie midpoint rule
% method = 4 --> ode45 (MATLAB routine)
% method = 5 --> closes run
% method > 5 --> gives error

method = 1:4;

%% TIME and STEPS
% T = end time of the simulation
% N_TIME = number of steps
T = 10;
N_TIME = 1e5 * ones(1, 4);

%% system parameters

k = 10;
damp = 0;

%% initial conditions

[q0, w0, z0] = initializeSE3();


for i = 1:N
    main(method(i), N_TIME(i), k, damp, z0, T)
    pause(1)
end

clearvars
