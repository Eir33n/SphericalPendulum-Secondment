%% number of tests

N = 5;

%% METHOD
% method = 1 --> explicit Lie Euler
% method = 2 --> implicit Lie Euler
% method = 3 --> implicit Lie midpoint rule
% method = 4 --> ode45 (MATLAB routine)
% method = 5 --> closes run
% method > 5 --> gives error

method = 2 * ones(1, 5);

%% TIME and STEPS
% T = end time of the simulation
% N_TIME = number of steps
T = 1;
N_TIME = [1e2; 1e3; 1e4; 1e5; 1e8];

%% system parameters

k = 0;
damp = 0.1;

%% initial conditions

z0 = [1; 0; 0; 0; 0; 0];


for i = 1:N
    main(method(i), N_TIME(i), k, damp, z0, T)
    pause(1)
end

clearvars
