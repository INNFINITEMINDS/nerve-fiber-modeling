%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to make Figure 4: Conduction reliability of physiological APs
% Inputs: Reliability values for mechanistic and functional models
% Outputs: Conduction reliability maps
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; close all; clear all;

% Load the relay values
load('/_data/functional_6um/relmat_phys.mat')
load('/_data/mechanistic_6um/relmat_phys.mat')
% Create the grid for scatter plot
f_stim = 1:4:51;
f_sen = 1:4:51;
X = meshgrid(f_sen); X = X(:);
Y = meshgrid(f_sen); Y = Y'; Y = Y(:);

% Plot the relay maps
% Reduced model
R_red = mean(rval_mat,3);
Rsd_red = std(rval_mat,[],3);
Rsd_req_r = Rsd_red(:)*10;

figure(1)
[C, h] = contourf(f_stim,f_sen,R_red');
clabel(C,h,'FontWeight','bold')
caxis([0.5 1])
hold on;

scatter(X,Y, Rsd_req_r, 'k','filled');

ax = gca; ax.FontWeight = 'bold'; ax.FontSize = 12;
hold off;

% Full model
R_full = mean(relmat,3);
Rsd_full = std(relmat,[],3);
Rsd_req_f = Rsd_full(:)*10;

figure(2)
[C, h] = contourf(f_stim,f_sen,R_full');
clabel(C,h,'FontWeight','bold')
caxis([0.5 1])
hold on;

scatter(X,Y, Rsd_req_f, 'k','filled');

ax = gca; ax.FontWeight = 'bold'; ax.FontSize = 12;
hold off;