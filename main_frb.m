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

inertia = diag([I1, I2, I3]);
invInertia = inv(inertia);

% initial angular momentum
m0 = rand(3, 1);
m0 = m0./norm(m0);

% attitude matrix
Q = eye(3);
Q = reshape(Q, 9, 1);

y0 = [m0; Q];

%% numerical parameters

t0 = 0;
te = 10;
atol = 1e-6;
rtol = 1e-6;

%% equations

f = @(t, y) freeRigidBody(y, invInertia);

%% solution

options = odeset('AbsTol', atol, 'RelTol', rtol);
ySol = ode45(f, [t0, te], y0);
