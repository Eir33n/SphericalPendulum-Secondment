function newSols = omega2qdot(sols)

newSols = sols;

[m, n] = size(sols);

if m == 1
    for i = 1:n
        for j = 1:size(sols{i}, 2)
            newSols{i}(4:6, j) = skw(sols{i}(4:6, j))*sols{i}(1:3, j);
        end
    end
elseif n == 1
    for i = 1:m
        for j = 1:size(sols{i}, 2)
            newSols{i}(4:6, j) = skw(sols{i}(4:6, j))*sols{i}(1:3, j);
        end
    end
end

end