function rslt = riemannianCurvature(u, v, w)

rslt = (transpose(w) * u) * v - (transpose(w) * v) * u;

end