function sol = readSol(which)
% Read the solution of the spherical pendulum
% from a txt file in the folder out/

if nargin == 0
   which = 0;
end

% all txt file in the directory
files = dir('out/*.txt');

% rearrange the file for creation data and saving the index
[~, sorti] = sort(cat(1, files.datenum));

% save the desired file name
if which <= 0
    filename = files(sorti(end+which)).name;
else
    filename = files(sorti(which)).name;
end

% open the file and saving the data
fileID = fopen(strcat('out/', filename), 'r');

formatSpec = '%e';
sizeSol = [6 Inf];
sol = fscanf(fileID, formatSpec, sizeSol);

fclose(fileID);

end