function [sols, params] = readUpto(upto)
% Read the solutions of the spherical pendulum
% from a txt file in the folder out/
% from the newest up to the number the user desires

% all txt file in the directory
files = dir('out/*.txt');

sols = cell(upto, 1);
params = cell(upto, 1);

for i = 0:upto-1
    filename = files(end-i).name;

    % open the file and saving the data
    fileID = fopen(strcat('out/', filename), 'r');
    
    formatSpec = '%e';
    sizeSol = [6 Inf];
    sols{i+1} = fscanf(fileID, formatSpec, sizeSol);
    
    fclose(fileID);
    
    % loading the parameters
    params{i+1} = load(strcat('out/', filename(1:end-7), 'prm.mat'));
end

end