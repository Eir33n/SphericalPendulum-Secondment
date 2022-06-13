function infos(params, what)

% this function tells me the info I required
% used to know what kind of solutions I have
[m, ~] = size(params);

if nargin < 2
    for i= 1:m
        disp(params{i})
    end
else
    for i = 1:m
        if isstring(params{i}.(what))
            info = params{i}.(what);
        else
            info = num2str(params{i}.(what));
        end
        mystr = strcat('In solution', {' '}, num2str(i), ' we have', {': '}, what, '=', info);
        disp(mystr)
    end
end

end