[sols, params] = readUpto(5);

% evaluate error

error = evalErr(sols, params);
plotErr(error)