% specify boundary values Y0 (t=0) and Y1 (t=1) [phi, theta, vphi, vtheta]
Y0 = [0, 0, - 0.5, 1];
Y1 = [0, pi, 1, 1];

q0,v0 = TS2.sph2vecs(Y0);
disp('q0, v0', q0, v0);
q1,v1 = TS2.sph2vecs(Y1);
disp('q1, v1:', q1, v1);

Res, L = TS2.geodesic_bvp(Y0, Y1);
Zarr = Res.y;
disp('Riemannian distance:', L);

% status message (how did the bvp-solver do)
disp(Res.message);

% disp the residuals of the boundary value conditions
disp('Y0-Zarr[1 : 4, 0]=', Y0 - Zarr(1 : 4, 0));
disp('Y1-Zarr[1 : 4, - 1]=', Y1 - Zarr(1 : 4, - 1));
disp('||Y0-Zarr[1 : 4, 0]||=', norm((Y0 - Zarr(1 : 4, 0)), 2));
disp('||Y1-Zarr[1 : 4, - 1]||=', norm((Y1  - Zarr(1 : 4, -1)), 2));

disp(Zarr.shape);
% disp(Zarr(0 , :]);


% Set up axes and draw the sphere
def setupAx(num, index, title, srad=1):
    ax = fig.add_subplot(1, num, index, projection='3d');
    ax.set_title(title);
    ax.view_init(elev = 0, azim = - 30);
%     ax.set_box_aspect((1, 1, 0.9));


    % Sphere
    u = linspace(0, 2 * pi, 100);
    v = inspace(0, pi, 100);
    x = srad * (cos(u))' * (sin(v));
    y = srad * (sin(u))' * (sin(v));
    z = srad * (ones(size(u)))' * (cos(v));
    ax.plot_surface(x, y, z, color='gray', alpha = 0.3);

    ax;

fig = plt.figure(figsize = [10, 10]);
ax = setupAx(1, 1, "Geodesics");

X = cos(Zarr(1,:)) * cos(Zarr(2,:));
Y = cos(Zarr(1,:)) * sin(Zarr(2,:));
Z = sin(Zarr(1,:));
ax.plot3D(X, Y, Z, color="black", linestyle='-');

n, m = Zarr.shape;

disp(n,m);
disp(L);
disp(norm(Y0-Y1));
P=np.round(linspace(0,m-1,11)).astype(int);
sfac = max([norm(Y0(2:end)), lnorm(Y0(2:end))]);
c="red";
for k = P(1):P(end)
    qq,vv=TS2.sph2vecs(Zarr(:,k));
    vvs = vv/sfac*0.5;
    ax.plot3D([qq(0),qq(0)+vvs(0)],[qq(1),qq(1)+vvs(1)], [qq(2),qq(2)+vvs(2)], color=c);
    c="blue";
end

plt.xlabel('x');
plt.show();
