function sols = readAll(many)
% reading all solutions file
% in the directory out/

% all txt files in the directory
files = dir('out/*.txt');
if nargin == 0
    [n, ~] = size(files);
    many = n;
end

sols = cell(many, 1);

% read all the files in the dir
for i = 1:many
    filename = files(i).name;
    fileID = fopen(strcat('out/', filename), 'r');

    formatSpec = '%e';
    sizeSol = [6 Inf];
    sols{i} = fscanf(fileID, formatSpec, sizeSol);
    
    fclose(fileID);
end

end