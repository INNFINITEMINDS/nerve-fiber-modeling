%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to make Figure 6 c-f: Interaction statistics at regions 1-6
% Inputs: Matrix of all interactions
% Outputs: Conduction reliability maps
%
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clear all; close all;
%% Load the master stats mat files
diam = [6, 9, 12];
points = [15 25 85 145 155];
labels = {'1', '2', '3', '4','5'};
ylimits = [60, 300, 600, 300];

for i =1:length(points)
    for k=1:length(diam)
        f_path = strcat('/_data/', int2str(diam(k)), 'um/stats_master_full.mat');
        load(f_path)
        
        X(:,i,k) = [mean(stats_master_full(:,1:4,points(i)))'];
        Y(:,i,k) = [std(stats_master_full(:,1:4,points(i)))'];
    end
end

%% Find significance by ANOVA
for j = 1:4
    for i =1:length(points)
        for k=1:length(diam)
            f_path = strcat('/_data/', int2str(diam(k)), 'um/stats_master_full.mat');
            load(f_path)
            
            inter(:,k,i) = squeeze(stats_master_full(:,j,points(i)));
        end
        [p, tb]  = anova1(inter(:,:,i), [], 'off');
        pval(i,j) = p;
        Fval(i,j) = tb{2,5};
        df1(i,j) = tb{2,3};
        df2(i,j) = tb{3,3};
    end
end

for j=1:size(X,1)
    vals_mean = squeeze(X(j,:,:));
    vals_std = squeeze(Y(j,:,:));
    
    figure(j)
    h = bar(vals_mean);ax = gca;
    sigstar({[0.7,1.3],[1.7,2.3],[2.7,3.3],[3.7,4.3],[4.7,5.3]},pval(:,j)');
    colormap 'summer'
    ax.FontWeight = 'bold'; ax.FontSize = 12;
    xticklabels(labels); ylim([0 ylimits(j)]);
    
    
    set(h,'BarWidth',1);    % The bars will now touch each other
    hold on;
    numgroups = size(vals_mean, 1);
    numbars = size(vals_mean, 2);
    groupwidth = min(0.8, numbars/(numbars+1.5));

    for i = 1:numbars
        % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
        x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
        errorbar(x, vals_mean(:,i), vals_std(:,i), 'k', 'linestyle', 'none');
    end
end
