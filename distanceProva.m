function rslt = distanceProva(sols, params)
% evaluating the distance using the norm of the
% Sasaki log map


% tutta questa roba non funziona!! controlla ancora bene tutto
% cerca di capire cosa sbagli e cosa invece va bene
% quali valori devono essere dati a delta??
% per molti valori non si converge!!!
sol1 = sols{1};
sol2 = sols{2};

n = params{1}.N_TIME;
nSteps = 5;
maxIt = 10;
delta = 0.001;
tol = 1e-3;

rslt = zeros(n, 1);

for time = 1:n
%     [v, w] = logMapS(sol1(1:3, time), sol1(4:6, time), ...
%                      sol2(1:3, time), sol2(4:6, time), ...
%                      nSteps, maxIt, tol, delta);
%     rslt(time) = norm([v; w]);

v = logMap(sol1(1:3, time), sol2(1:3, time));
w = parallelTranslationAtoB(sol2(1:3, time), sol1(1:3, time), sol2(4:6, time)) - sol1(4:6, time);

rslt(time) = norm([v; w]);
end

end