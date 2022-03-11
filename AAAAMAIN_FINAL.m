clc;
clear all;
close all;

prompt = 'How many 3D pendulums do you want to connect?\n\n';
P = input(prompt);

L = rand(P,1); 
m = rand(P,1);

L = 0*L + 1; 
m = 0*m + 1;

damp=input('damping = \n');

[q0,w0,z0] = initializeSE3N(P);
% [q0,w0,z0] = initializeSE3N_smallVariation(P);
% [q0,w0,z0] = initializeSE3N_largeVariation(P);
% w0 = [0; 0; 0];
% z0(4:end) = w0;

Energy = @(q,w) 0.5*w'*assembleR(q,L,m)*w + potential(q,L,m);

disp("Energy of this initial condition: "+num2str(Energy(q0,w0)));

t0 = 0;
T = 5; 
N = 10000; 
time = linspace(t0,T,N); 
dt = time(2)-time(1);

getq = @(v) extractq(v);
getw = @(v) extractw(v);

f = @(v) fManiToAlgebra(getq(v),getw(v),L,m, damp); 
action = @(B,input) actionSE3N(B,input); 
vecField = @(sigma,p) dexpinvSE3N(sigma,f(action(exponentialSE3N(sigma),p)));


z = z0;
qC = zeros(3*P,N);
pC = qC;

Len = zeros(3*P,1);
for i = 1:P
    Len(3*i-2:3*i) = L(i)*ones(3,1);
end
Mat = diag(Len);
if P>1
    for i = 3:3:3*(P-1)
        Mat = Mat + diag(Len(1:3*P-i),-i);
    end
end
qC(:,1) = q0;
pC(:,1) = Mat*q0;

%% TIME EVOLUTION OF THE SOLUTION

prompt = 'Do you want to see the Time Evolution of the solution? Write 1 for yes, 0 for no\n\n';
C1 = input(prompt);

zC = zeros(6*P,N);
if C1==1
    zC(:,1) = z0;
    for i = 1:N-1
%         zC(:,i+1) = FreeRK4SE3N(f,action,dt,zC(:,i));
        zC(:,i+1) = LieEulerSE3N(vecField,action, zC(:,i), dt);
        qC(:,i+1) = extractq(zC(:,i+1));
        pC(:,i+1) = Mat*qC(:,i+1);
    end

    %     sphere
%     axis equal
    figure('Units','normalized','Position',[0 0 1 1])
    t = 0;
    for i = 1:100:N
        t = dt*i;
%         sphere(100)
%         axis equal
%         colormap(white)
% %         mesh(ax,'none')
%         mesh('FaceAlpha','0.1')
        [x y z] = sphere(128);
        h = surfl(x, y, z); 
        set(h, 'FaceAlpha', 0.1)
        s.EdgeColor = 'none';
        shading flat
        plot3([0,pC(1,i)],[0,pC(2,i)],[0,pC(3,i)],'r*',...
            [pC(3*(1:P-1)-2,i),pC(3*(1:P-1)+1,i)],[pC(3*(1:P-1)-1,i),pC(3*(1:P-1)+2,i)],...
                [pC(3*(1:P-1),i),pC(3*(1:P-1)+3,i)],'k-o','Markersize',4);
        xlabel("x")
        ylabel("y")
        zlabel("z")
        str = "Time evolution of the pendulums, T="+num2str(t);
        axis([-sum(L) sum(L) -sum(L) sum(L) -sum(L) sum(L)]);
        title(str)
        pause(0.00000000000001);
        hold on
    end
end

wC = zeros(3*P,N);
kinetic_energy = zeros(N,1);
potential_energy = zeros(N,1);

wC(:,1) = w0;
kinetic_energy(1) = 0.5*wC(:,1)'*assembleR(qC(:,1),L,m)*wC(:,1);
potential_energy(1) = potential(qC(:,1),L,m);

zC(:,1) = z0;
for i = 1:N-1
    zC(:,i+1) = LieEulerSE3N(vecField,action, zC(:,i), dt);
%     zC(:,i+1) = FreeRK4SE3N(f,action,dt, zC(:,i));

    qC(:,i+1) = extractq(zC(:,i+1));
    wC(:,i+1) = extractw(zC(:,i+1));
    kinetic_energy(i+1) = 0.5*wC(:,i+1)'*assembleR(qC(:,i+1),L,m)*wC(:,i+1);
    potential_energy(i+1) = potential(qC(:,i+1),L,m);
end

figure(2)
plot(qC(1,:), wC(1,:))
hold on
plot(qC(1,1), wC(1,1), 'ro', 'MarkerSize', 5)
figure(3)
plot(qC(2,:), wC(2,:))
hold on 
plot(qC(2,1), wC(2,1), 'ro', 'MarkerSize', 5)
figure(4)
plot(qC(3,:), wC(3,:))
hold on 
plot(qC(3,1), wC(3,1), 'ro', 'MarkerSize', 5)
figure(5)
plot(time, (potential_energy+kinetic_energy), time, kinetic_energy, time, potential_energy, 'LineWidth', 3)
legend('total', 'kinetic', 'potential')


figure(6)

plot(time, (potential_energy+kinetic_energy), 'LineWidth', 3)


    %% PRESERVATION OF THE GEOMETRY

if P==2
    prompt = 'Do you want to see the Time Evolution of norms of the solution? Write 1 for yes, 0 for no\n\n';
    C2 = input(prompt);

    if C2==1

        [nn,NN] = compareNorms(f,action,vecField,z0,L,m);
        times = linspace(0,5,NN);
        
         subplot(4, 2, 1)
         plot(times, 1-nn(:,:,1).^2,'-','linewidth',2);
%          yticks(1)
         xlim([0 5])
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('ODE45','fontsize',14);
         
         subplot(4, 2, 2)
         plot(times, 1-nn(:,:,2).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RK4','fontsize',14);
         
         subplot(4, 2, 3)
         plot(times, 1-nn(:,:,3).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Lie Euler','fontsize',14);
         
         subplot(4, 2, 4)
         plot(times, 1-nn(:,:,4).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Lie Euler Heun','fontsize',14);
         
         subplot(4, 2, 5)
         plot(times, 1-nn(:,:,5).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Comm. Free RKMK 4','fontsize',14);
         
         subplot(4, 2, 6)
         plot(times, 1-nn(:,:,6).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RKMK 4','fontsize',14);
         
         subplot(4, 2, 7)
         plot(times, 1-nn(:,:,7).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RKMK 4 with 2 commutators','fontsize',14);

         subplot(4, 2, 8)
         plot(times, 1-nn(:,:,8).^2,'-','linewidth',2);
         xlim([0 5])
%          yticks(1)
         legend('$q_1$','$q_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Norm",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RKMK 3','fontsize',14);
         
        
         
%          h = sgtitle("$1-q_i(t)^Tq_i(t)$",'interpreter','latex');
        sgtitle("1-q_i(t)^Tq_i(t)","FontSize",25);
    end




    prompt = 'Do you want to see the Time Evolution of the scalar products w'' * q? Write 1 for yes, 0 for no\n\n';
    C3 = input(prompt);

    if C3==1

        [nn,NN] = tangentBehaviour(f,action,vecField,z0,L,m);
        times = linspace(0,5,NN);
        
        n1 = nn(:,:,1);
        n2 = nn(:,:,2);
        n3 = nn(:,:,3);
        n4 = nn(:,:,4);
        n5 = nn(:,:,5);
        n6 = nn(:,:,6);
        n7 = nn(:,:,7);
        n8 = nn(:,:,8);
        
        figure;
         subplot(4, 2, 1)
         plot(times, nn(:,:,1),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('ODE45','fontsize',14);
         
         subplot(4, 2, 2)
         plot(times, nn(:,:,2),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Classical RK4','fontsize',14);
         
         subplot(4, 2, 3)
         plot(times, nn(:,:,3),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Lie Euler','fontsize',14);
         
         subplot(4, 2, 4)
         plot(times, nn(:,:,4),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Lie Euler Heun','fontsize',14);
         
         subplot(4, 2, 5)
         plot(times, nn(:,:,5),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('Commutator Free RKMK 4','fontsize',14);
         
         subplot(4, 2, 6)
         plot(times, nn(:,:,6),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RKMK 4','fontsize',14);
         
         subplot(4, 2, 7)
         plot(times, nn(:,:,7),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RKMK 4 with 2 commutators','fontsize',14);
         
         subplot(4, 2, 8)
         plot(times, nn(:,:,8),'-','linewidth',2);
         xlim([0 5])
         legend('$q_1^T\omega_1$','$q_2^T \omega_2$','interpreter','latex','FontSize',14,'Location', 'southwest');
         xlabel("Time",'fontsize',14);
         ylabel("Product",'fontsize',14);
         ax = gca;
         ax.XAxis.FontSize = 15;
         ax.YAxis.FontSize = 15;
         title('RKMK 3','fontsize',14);
         
%          h = sgtitle("$q_i(t)^T\omega_i(t)$",'interpreter','latex');
         sgtitle("q_i(t)^T\omega_i(t)","FontSize",25);
    end
end
