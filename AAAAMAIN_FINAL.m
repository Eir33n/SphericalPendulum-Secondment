clc
clear
close all

%% INITIALIZATION OF THE PROBLEM

L = 1; 
m = 1;

damp = input('Insert a damping value = \n');
% damp = 0.01;

% [q0, w0, z0] = initializeZeroVel();
[q0, w0, z0] = initializeSE3N(1);
% [q0, w0, z0] = initializeSE3N_smallVariation(1);
% [q0, w0, z0] = initializeSE3N_largeVariation(1);

% q0 = [0; 1; 0]; w0 = [0; 0.3; 0]; z0 = [q0; w0];

Energy_kinetic = @(q, w) 0.5 * w' * assembleR_diag(L, m) * w;
Energy_potential = @(q, w) potential(q, L, m);

disp("Energy of this initial condition: " + ...
    num2str(Energy_kinetic(q0, w0) + Energy_potential(q0, w0)));

t0 = 0;
T = 10; 
N_TIME = 100000; 
time = linspace(t0, T, N_TIME); 
dt = time(2) - time(1); disp(num2str(dt) + " time step size")

max_it = 10;
tol = 1e-10;

getq = @(v) v(1:3);
getw = @(v) v(4:6);

f = @(v) fManiToAlgebra(getq(v), getw(v), L, m, damp); 
action = @(B, input) actionSE3(B, input);

qC = zeros(3, N_TIME);
wC = zeros(3, N_TIME);
kinetic_energy = zeros(N_TIME, 1);
potential_energy = zeros(N_TIME, 1);

qC(:, 1) = q0;
wC(:, 1) = w0;
kinetic_energy(1) = Energy_kinetic(qC(:, 1), wC(:, 1));
potential_energy(1) = Energy_potential(qC(:, 1), wC(:, 1));
Len = zeros(3, 1);

%% SOLUTION OF THE SYSTEM

zC = zeros(6, N_TIME);
zC(:, 1) = [q0; w0];
for i = 1:N_TIME-1
%     zC(:, i+1) = LieEulerSE3(f, action, zC(:, i), dt);
    zC(:, i+1) = ImplicitLieEulerSE3(f, action, ...
                                     zC(:, i), dt, max_it, tol);

    qC(:, i+1) = getq(zC(:, i+1));
    wC(:, i+1) = getw(zC(:, i+1));
    kinetic_energy(i+1) = Energy_kinetic(qC(:, i+1), wC(:, i+1));
    potential_energy(i+1) = Energy_potential(qC(:, i+1), wC(:, i+1));
end

%% TIME EVOLUTION OF THE SOLUTION

prompt = 'Do you want to see the Time Evolution of the solution? Write 1 for yes, 0 for no\n\n';
C1 = input(prompt);

if C1
    P = 1;
    figure('Units','normalized','Position',[0 0 1 1])
    t = 0;
    for i = 1:floor(N_TIME/50):N_TIME
        t = dt*i;
        % Create sphere surface
        [x, y, z] = sphere(128);
        h = surfl(x, y, z); 
        set(h, 'FaceAlpha', 0.1)
        s.EdgeColor = 'none';
        shading flat
        % Plot pendulum at time step i
        plot3([0,qC(1,i)],[0,qC(2,i)],[0,qC(3,i)],'r*',...
            [qC(3*(1:P-1)-2,i),qC(3*(1:P-1)+1,i)],[qC(3*(1:P-1)-1,i),qC(3*(1:P-1)+2,i)],...
                [qC(3*(1:P-1),i),qC(3*(1:P-1)+3,i)],'k-o','Markersize',4);
        xlabel("x")
        ylabel("y")
        zlabel("z")
        str = "Time evolution of the pendulums, T="+num2str(t);
        axis([-sum(L) sum(L) -sum(L) sum(L) -sum(L) sum(L)]);
        title(str)
        pause(0.0000000000001);
        hold on
    end
end

figure(2)
plot(qC(1,:), wC(1,:), 'LineWidth', 2)
hold on
plot(qC(2,:), wC(2,:), 'LineWidth', 2)
plot(qC(1,1), wC(1,1), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
plot(qC(2,1), wC(2,1), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')
legend('x-coordinate', 'y-coordinate')
xlabel('\textbf{q}', Interpreter='latex', FontSize=16)
ylabel('$\dot{\textbf{q}}$', Interpreter='latex', FontSize=16)
grid()

figure(3)
ax(1) = subplot(2, 1, 1);
plot( time, (potential_energy+kinetic_energy), time, potential_energy, time, kinetic_energy, LineWidth=3)
ylabel('Energy', FontSize=16)
legend('Total Energy', 'Potential Energy', 'Kinetic Enrgy')
grid()
ax(2) = subplot(2, 1, 2);
plot(time, (potential_energy+kinetic_energy), LineWidth=3)
ylabel('Total Energy', FontSize=16)
grid()

linkaxes(ax,'x');
xlabel('Time', FontSize=16)




