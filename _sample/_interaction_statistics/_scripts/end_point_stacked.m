%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to make Figure 6 b: Output firing ratio
% Inputs: Matrix of all interactions
% Outputs: Conduction reliability maps
%
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; close all;
% load all the required files
%% Load the master stats mat files
diam = [6, 9, 12];
points = [15 25 85 145 155];
labels = {'1', '2', '3', '4','5'};

for k=1:length(diam)
    f_path = strcat('/_data/', int2str(diam(k)), 'um/');
    cd(f_path)
    mat = dir('*.mat');
    for q = 1:length(mat)
        load(mat(q).name);
    end


% Now to find the percentage of end point AP's due to stimulus and
% physiological activity

% Full model

F_stim_full = stimat./(stimat+colmat+senmat);

% Now plot a bar for the five locations mentioned in Fig 4

points = [2 2; 2 12; 7 7; 12 2; 12 12];
labels = {'1', '2', '3', '4', '5'};


for j =1:length(points)
    X_stim = [mean(F_stim_full(points(j,1),points(j,2),:))];
    X_phys = 1 - X_stim;
    stackData(j,k,1) = X_stim;
    stackData(j,k,2) = X_phys;
end
end

% Plot the bars
% labels to use on tick marks for groups 
plotBarStackGroups(stackData,labels);
ax = gca; ax.FontWeight = 'bold'; ax.FontSize = 12;
box on;

