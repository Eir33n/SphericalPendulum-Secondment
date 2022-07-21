% main for frb
clearvars
close all

%% physical parameters

% inertia tensor
I1 = rand(1);
I2 = rand(1);
if I2 > I1
    tmp = I1;
    I1 = I2;
    I2 = tmp;
end
I3 = 1;

inertia = diag([1/I1, 1/I2, 1/I3]);

% initial angular momentum
m0 = rand(3, 1);
m0 = m0./norm(m0);

% attitude matrix
Q = eye(3);
Q = reshape(Q, 9, 1);

y0 = [m0; Q];

alpha = 0.1;

%% numerical parameters

t0 = 0;
te = 10;
atol = 1e-6;
rtol = 1e-6;

%% equations

if exist('alpha','var')
    f = @(t, y) freeRigidBody(y, inertia, alpha);
else
    f = @(t, y) freeRigidBody(y, inertia);
end

%% solution

options = odeset('AbsTol', atol, 'RelTol', rtol);
ySol = ode45(f, [t0, te], y0);

nTime = size(ySol.x, 2);
time = linspace(t0, te, nTime);
zSol = ySol.y;
mSol = deval(ySol, time, 1:3);
QSol = deval(ySol, time, 3 + (1:9));

%% energy evaluation

kinEnergy = zeros(nTime, 1);
energy = @(m) 0.5 * m' * inertia * m;

for i = 1:nTime
    kinEnergy(i) = energy(mSol(:, i));
end

%% plots

figure()
plot(time, mSol(1, :), time, mSol(2, :), time, mSol(3, :), LineWidth=1.5)
legend('mx','my','mz')
grid on
title('Angular Momenta', 'FontSize', 20)
xlabel('time', FontSize=16)
ylabel('angular momenta', FontSize=16)

figure()
plot(time, kinEnergy, LineWidth=1.5)
grid on
title('Kinetic Energy', 'FontSize', 20)
xlabel('time', FontSize=16)
ylabel('Kinetic energy', FontSize=16)
