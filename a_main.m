clearvars -except z0
% close all
%% NUMERICAL PARAMETERS

% CHOOSE A METHOD
method = input(['Choose a method:\nWrite a number for...\n[0]...explicit Lie Euler Method\n' ...
    '[1]...implicit Lie Euler Method\n[2]...implicit Lie Midpoint Rule\n']);

% DEFINITION OF NUMERICAL PARAMETERS AND TIME INTEGRATION
% initial and final time
% number of time steps
% time vector
% time step size
% maximal iteration steps for implicit methods
% tolerance
% (TODO: insert relative and absolute tolerance)
t0 = 0;
T = 2; 
N_TIME = 10000; 
time = linspace(t0, T, N_TIME); 
dt = time(2) - time(1); disp(num2str(dt) + " time step size")

max_it = 10;
tol = 1e-10;

%% PHYSICAL PARAMETERS

% LENGTH, MASS AND DAMPING OF THE PENDULUM
L = 1; 
m = 1;
damp = input('Insert a (non-positive) damping value = \n');

%% DEFINITION OF USEFUL FUNCTIONS

% ENERGY EVALUATION
Energy_kinetic = @(q, w) 0.5 * w' * eye(3) * w;
Energy_potential = @(q, w) potential(q, L, m);

% RETRIEVE POSITION AND ANGULAR VELOCITY FROM THE SOLUTION VECTOR
getq = @(v) v(1:3);
getw = @(v) v(4:6);

% RHS OF THE SYSTEM, RESIDUAL AND JACOBIAN FOR IMPLICIT METHODS
f = @(v) fManiToAlgebra(getq(v), getw(v), L, m, damp); 
action = @(B, input) actionSE3(B, input);
myRes = @(v0, v, h) residualSE3(v0, v, h, f, action, method);
myJac = @(v0, v, h) jacobianSE3(v0, v, h, f, action, method);

%% INITIALIZATION OF THE PROBLEM

% [q0, w0, z0] = initializeZeroVel();
% if exist('z0','var')
%     [q0, w0, z0] = initializeSmallVariation(z0);
% else
%     [q0, w0, z0] = initializeSE3();
% end
q0 = [0; 1; 0]; w0 = [0; 0.3; 0]; z0 = [q0; w0];

disp(['The initial configuration of this run is: ', newline, ...
    '[', num2str(q0(1)), ' ', num2str(q0(2)), ' ', num2str(q0(3)), ']', ' position', newline, ...
    '[', num2str(w0(1)), ' ', num2str(w0(2)), ' ', num2str(w0(3)), ']', ' angular velocity'])

qSol = zeros(3, N_TIME);
wSol = zeros(3, N_TIME);
zSol = zeros(6, N_TIME);
kinetic_energy = zeros(N_TIME, 1);
potential_energy = zeros(N_TIME, 1);

qSol(:, 1) = q0;
wSol(:, 1) = w0;
zSol(:, 1) = z0;
kinetic_energy(1) = Energy_kinetic(qSol(:, 1), wSol(:, 1));
potential_energy(1) = Energy_potential(qSol(:, 1), wSol(:, 1));

disp("Energy of this initial condition: " + ...
    num2str(kinetic_energy(1) + potential_energy(1)));

%% SOLUTION OF THE SYSTEM

for i = 1:N_TIME-1
    if method == 0
        zSol(:, i+1) = LieEulerSE3(f, action, zSol(:, i), dt);
    else
        zSol(:, i+1) = NewtonItSE3(myRes, myJac, zSol(:, i), dt, max_it, tol);
    end

    qSol(:, i+1) = getq(zSol(:, i+1));
    wSol(:, i+1) = getw(zSol(:, i+1));
    kinetic_energy(i+1) = Energy_kinetic(qSol(:, i+1), wSol(:, i+1));
    potential_energy(i+1) = Energy_potential(qSol(:, i+1), wSol(:, i+1));
end

%% TIME EVOLUTION OF THE SOLUTION
plotsPlus = questdlg('Post processing analysis?', ...
    'Plots and Animations', 'Yes, all', ...
    'Yes, just plots', 'No, thank you!','Yes, all');

switch plotsPlus
    case 'Yes, all'
        animation(qSol, N_TIME, dt);
        post_plots(qSol, wSol, kinetic_energy, potential_energy, time);
%     case 'Yes, just animation'
%         animation(qSol, N_TIME, dt);
    case 'Yes, just plots'
        post_plots(qSol, wSol, kinetic_energy, potential_energy, time);
    case 'No, thank you!'
        disp('Thank you for using me! Have a nice day!\n')
end

%% MORE SIMULATIONS?
run = questdlg('Do you want to perform a new simulation?', ...
    'New Simulation', 'Yes', 'No, thank you!','Yes');
if strcmp(run, 'Yes')
    go_on = input(['Remember to save before restarting the program.' ...
        'Press ENTER to proceed.\n']);
    a_main
else
    disp('It was a pleasure serving you!')
    clearvars z0
end

%% USEFUL POST PROCESSING FUNCTIONS

function animation(q, steps, dstep)
        figure('Units','centimeters','Position',[10 10 20 15])
        % Create sphere surface
        [xS2, yS2, zS2] = sphere(360);
        h = surf(xS2, yS2, zS2, 'FaceAlpha', 0.1); 
        h.EdgeColor = 'none';
        hold on
        for i = 1:steps/200:steps
            % Plot pendulum at time step i
            plot3([0, q(1,i)], [0, q(2,i)], [0, q(3,i)], 'r*');
            xlabel("x")
            ylabel("y")
            zlabel("z")
            str = "Time evolution of the pendulums, T="+num2str(dstep*i);
            axis equal;
            title(str)
            pause(0.0000000000001);
        end
        hold off
end

function post_plots(q, w, K, P, timeVec)
    figure('Name','Phase Space')
    plot(q(1,:), w(1,:), 'LineWidth', 2)
    hold on
    plot(q(2,:), w(2,:), 'LineWidth', 2)
    plot(q(3,:), w(3,:), 'LineWidth', 2)
    plot(q(1,1), w(1,1), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
    plot(q(2,1), w(2,1), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
    plot(q(3,1), w(3,1), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
    legend('x-coordinate', 'y-coordinate', 'z-coordiante')
    xlabel('\textbf{q}', Interpreter='latex', FontSize=16)
    ylabel('$\dot{\textbf{q}}$', Interpreter='latex', FontSize=16)
    grid()
    hold off

    figure('Name','Energy of the System')
    ax(1) = subplot(2, 1, 1);
    plot(timeVec, (K+P), timeVec, P, timeVec, K, LineWidth=3)
    ylabel('Energy', FontSize=16)
    legend('Total Energy', 'Potential Energy', 'Kinetic Energy')
    grid()
    ax(2) = subplot(2, 1, 2);
    plot(timeVec, (K+P), LineWidth=3)
    ylabel('Total Energy', FontSize=16)
    grid()
    linkaxes(ax,'x');
    xlabel('Time', FontSize=16)
   
end

