function [v, w] = logMapS(p0, u0, pL, uL, nSteps, maxIt, tol, delta)
% The algorithm follows the paper
% [1] P. Muralidharan, T.P. Fletcher.
% Sasaki Metrics for Analysis of Longitudinal Data on Manifolds. (2012)

% parameter
epsilon = 1 / nSteps;

% vector of intermediate discrete (p_k, u_k)
p = zeros(3, nSteps);
u = zeros(3, nSteps);

% evaluate the initial velocity of the geodesic between p0, pL
v0 = logMap(p0, pL);
w0 = uL - parallelTranslation(p0, v0, u0);

% discretize the entire geodesic + 
% linearly interpolate between u0 and uL
p(:, 1) = p0; p(:, end) = pL;
u(:, 1) = u0; u(:, end) = uL;
for k = 2:nSteps-1
    t = (k-1) * epsilon; % k-1 because the index starts with 1 and not 0
                         % the time step is starting with 1*eps (!!!)
    p(:, k) = expMap(p0, v0 * t);
    left_u = parallelTranslation(p0, v0 * t, u0);
    right_u = parallelTranslationAtoB(pL, p(:, k), uL);
    u(:, k) = (1 - t) * left_u + t * right_u;
end

% minimization of the discrete geodesic energy
% E(p, u) = sum(norm(v)^2 + norm(w)^2)
% intuitively : looking for the curve with zero acceleration
% min(E) --> "v = 0" and "w = 0" --> p0 and u0 constant
% since pL ~= p0 and uL ~= u0, then v ~= 0 and w ~= 0

% initialize velocity vector in TTM
v = zeros(3, nSteps);
w = zeros(3, nSteps);

v(:, 1) = v0;
w(:, 1) = w0;

% % % for iter = 1:maxIt
% % %     gradE = 0;
% % %     for k = 2:nSteps-1
% % %         % current v --> v^i_k Equation (7) on [1]
% % %         v(:, k) = logMap(p(:, k), p(:, k+1)) / epsilon;
% % %         left_u = parallelTranslation(p(:, k-1), v(:, k-1), u(:, k-1));
% % %         right_u = parallelTranslationAtoB(p(:, k+1), p(:, k), u(:, k+1));
% % %         % current w --> w^i_k Equation (8) on [1]
% % %         w(:, k) = (right_u - left_u) / (2 * epsilon);
% % %         % computing gradients of v and w as central differences
% % %         left_v = parallelTranslation(p(:, k-1), v(:, k-1), v(:, k-1));
% % %         dv = (v(:, k) - left_v) / epsilon^2;
% % %         dw = (right_u - 2 * u(:, k) + left_u) / epsilon^2;
% % % 
% % %         % gradient of the energy w.r.t. p and u
% % %         curv = riemannianCurvature(u(:, k), w(:, k), v(:, k));
% % %         grad_p_E = dv + curv;
% % %         grad_u_E = dw;
% % %         
% % %         % updating p_k and u_k following the negative gradient
% % %         p_old = p(:, k);
% % %         p(:, k) = expMap(p(:, k), delta * grad_p_E);
% % %         u(:, k) = parallelTranslationAtoB(p_old, p(:, k), ...
% % %                                        u(:, k) + delta * grad_u_E);
% % % 
% % %         % updating the value of the gradient of E
% % %         gradE = gradE + (norm(grad_p_E)^2 + norm(grad_u_E)^2);
% % %     end
% % %     % checking the value of the gradient of E
% % %     if gradE < tol
% % %         break
% % %     end
% % % end


for iter = 1:maxIt
    gradE = 0;
    for k = 2:nSteps-1
        left_p = p(:, k-1); crr_p = p(:, k); right_p = p(:, k+1);
        left_u = u(:, k-1); crr_u = u(:, k); right_u = u(:, k+1);
        left_v = logMap(left_p, crr_p); crr_v = logMap(crr_p, right_p);
        minusright_v = logMap(right_p, crr_p);
        left_v_crrp = parallelTranslation(left_p, left_v, left_v);
        left_u_crrp = parallelTranslation(left_p, left_v, left_u);
        right_u_crrp = parallelTranslation(right_p, minusright_v, right_u);
        % current v --> come in loro codice
        v(:, k) = (crr_v + left_v_crrp) / (2 * epsilon);
        % current w --> come in loro codice
        w(:, k) = (right_u_crrp - left_u_crrp) / (2 * epsilon);
        % computing gradients of v and w as central differences
        dv = (crr_v - left_v_crrp) / epsilon^2;
        dw = (right_u_crrp - 2 * crr_u + left_u_crrp) / epsilon^2;

        % gradient of the energy w.r.t. p and u
        curv = riemannianCurvature(u(:, k), w(:, k), v(:, k));
        grad_p_E = dv + curv;
        grad_u_E = dw;
        
        % updating p_k and u_k following the negative gradient
        p(:, k) = p(:, k) + grad_p_E * delta;
        u(:, k) = u(:, k) + grad_u_E * delta;

        % updating the value of the gradient of E
        gradE = gradE + (norm(grad_p_E)^2 + norm(grad_u_E)^2);
    end
    % checking the value of the gradient of E
    if gradE < tol
        break
    end
end

if gradE > tol
    disp('Relaxation did not converged.')
end

% result of the Sasaki log map
% % v = logMap(p0, p(:, 2)) / epsilon;
% % w = (parallelTranslationAtoB(p(:, 2), p0, u(:, 2)) - u0) / epsilon;

v = logMap(p0, p(:, 2)) / epsilon;
w = (parallelTranslationAtoB(p(:, 2), p0, u(:, 2)) - u0) / epsilon;
end