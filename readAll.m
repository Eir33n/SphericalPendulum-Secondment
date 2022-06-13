function [sols, params] = readAll(many)
% reading all solutions file
% in the directory out/
% from the oldest to the newest
% one can stop after the first 'many'

% all txt files in the directory
files = dir('out/*.txt');
if nargin == 0
    [n, ~] = size(files);
    many = n;
end

sols = cell(many, 1);
params = cell(many, 1);

for i = 1:many
    filename = files(i).name;
    fileID = fopen(strcat('out/', filename), 'r');

    formatSpec = '%e';
    sizeSol = [6 Inf];
    sols{i} = fscanf(fileID, formatSpec, sizeSol);
    
    fclose(fileID);

    params{i} = load(strcat('out/', filename(1:end-7), 'prm.mat'));
end

end