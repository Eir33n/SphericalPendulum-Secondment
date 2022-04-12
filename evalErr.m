function error = evalErr(sols, ref)

% Error functions
norm2 = @(x) sqrt(sum(x.^2, 1)/size(x, 1));
abserr = @(x, xref) max(norm2(x - xref));
relerr = @(x, xref) max(norm2(x - xref) ./ norm2(xref));

[m, ~] = size(sols);
error = cell(4, m);
for k = 1:m
    crrSol = sols{k};
    N = round(size(ref,2)/size(crrSol, 2));
    % absolute error (q and w)
    error{1, k} = abserr(crrSol(1:3, :), ref(1:3, 1:N:end));
    error{2, k} = abserr(crrSol(4:6, :), ref(4:6, 1:N:end));
    % relative error (q and w)
    error{3, k} = relerr(crrSol(1:3, :), ref(1:3, 1:N:end));
    error{4, k} = relerr(crrSol(4:6, :), ref(4:6, 1:N:end));
end

end