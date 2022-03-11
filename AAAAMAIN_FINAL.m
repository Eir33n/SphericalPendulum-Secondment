clc
clear
close all

%% INITIALIZATION OF THE PROBLEM

L = 1; 
m = 1;

damp = input('Insert a damping value = \n');

[q0, w0, z0] = initializeZeroVel();
% [q0, w0, z0] = initializeSE3N(P);
% [q0, w0, z0] = initializeSE3N_smallVariation(P);
% [q0, w0, z0] = initializeSE3N_largeVariation(P);

Energy_kinetic = @(q, w) 0.5 * w' * assembleR_diag(L, m) * w;
Energy_potential = @(q, w) potential(q, L, m);

disp("Energy of this initial condition: " + ...
    num2str(Energy_kinetic(q0, w0) + Energy_potential(q0, w0)));

t0 = 0;
T = 5; 
N_TIME = 100000; 
time = linspace(t0, T, N_TIME); 
dt = time(2) - time(1);

max_it = 10;
tol = 1e-10;

getq = @(v) v(1:3);
getw = @(v) v(4:6);

f = @(v) fManiToAlgebra(getq(v), getw(v), L, m, damp); 
action = @(B, input) actionSE3(B, input);
jacobian = @(v, h) jacobianSE3(v, h, m, L, damp);

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
    zC(:, i+1) = ImplicitLieEulerSE3(f, action, jacobian, ...
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
    for i = 1:25:N_TIME
        t = dt*i;
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
plot(qC(1,:), wC(1,:))
hold on
plot(qC(1,1), wC(1,1), 'ro', 'MarkerSize', 5)
plot(qC(2,:), wC(2,:))
plot(qC(2,1), wC(2,1), 'ro', 'MarkerSize', 5)

figure(3)
plot(time, potential_energy, time, kinetic_energy, time, (potential_energy+kinetic_energy), LineWidth=3)
legend('potential', 'kinetic', 'total')

figure(4)
plot(time, (potential_energy+kinetic_energy), LineWidth=3)

%% PRESERVATION OF THE GEOMETRY
% subplot(4, 2, 3)
% plot(times, 1-nn(:,:,3).^2,'-','linewidth',2);
% xlim([0 5])
% % yticks(1)
% legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
% xlabel("Time",'fontsize',14);
% ylabel("Norm",'fontsize',14);
% ax = gca;
% ax.XAxis.FontSize = 15;
% ax.YAxis.FontSize = 15;
% title('Lie Euler','fontsize',14);