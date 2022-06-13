function [p, u, v, w] = expMapS(p0, u0, v0, w0, epsilon)

p = expMap(p0, epsilon * v0);
u = parallelTranslationAtoB(p0, p, u0 + epsilon * w0);
v = parallelTranslationAtoB(p0, p, v0 - epsilon * riemannianCurvature(u0, w0, v0));
w = parallelTranslationAtoB(p0, p, w0);

end