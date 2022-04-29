function z0 = startingValue()
% This function retreives the initial values of precedent simulation
% or allows the user to insert a personalized initial condition

% all txt files in the directory
files = dir('out/*.txt');
[n, ~] = size(files);
initList = zeros(6, n);
listStr = cell(n+1, 1);

for i = 1:n
    filename = files(i).name;
    fileID = fopen(strcat('out/', filename), 'r');

    C = textscan(fileID, '%s %s %s %s %s %s', 1, 'Delimiter', ' ');
    for j = 1:6
        initList(j, i) = str2double(C{j}(1,1));
    end

    fclose(fileID);

    listStr{i} = strcat('[', num2str(initList(1, i)), '; ', num2str(initList(2, i)), '; ', num2str(initList(3, i)), '; ', ...
                             num2str(initList(4, i)), '; ', num2str(initList(5, i)), '; ', num2str(initList(6, i)), ']');
end

listStr{n+1} = 'Insert personal.';

init =  listdlg('PromptString',{'Choose an initialization'}, ...
    'ListString',listStr, 'SelectionMode', 'single', 'ListSize', [300 160]);

if init > n
    answer = inputdlg('Enter six space-separated numbers:', 'Initial values', [1 50]);
    z0 = str2num(answer{1});
    z0 = transpose(z0);
else
    z0 = initList(:, init);
end

end