function [sols, params] = readUpto(upto, old)
% Read the solutions of the spherical pendulum
% from a txt file in the folder out/
% from the newest up to the number the user desires

if nargin < 2
    old = 0;
end

% all txt file in the directory
if old == 1
    files = dir('out/*.txt');
else
    files = dir('out/*sol.mat');
end

sols = cell(upto, 1);
params = cell(upto, 1);

for i = 0:upto-1
    filename = files(end-i).name;

    % open the file and saving the data
    if old == 1
        fileID = fopen(strcat('out/', filename), 'r');
        
        formatSpec = '%e';
        sizeSol = [6 Inf];
        sols{i+1} = fscanf(fileID, formatSpec, sizeSol);
        
        fclose(fileID);
    else
        sols{i+1} = load(strcat('out/', filename));
        sols{i+1} = sols{i+1}.zSol;
    end
    
    % loading the parameters
    params{i+1} = load(strcat('out/', filename(1:end-7), 'prm.mat'));
end

end