%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to find reliability using full model from neuron simulated data
% Inputs: folder - Main folder where the neuron simulation data is stored
%         stimFreq, senFreq - Stimulus and physiological frequencies  
%         numIter - Number of iteractions (50)
%         zcount - number of nodes (30 - 6um, 21 - 9um, 15 - 12um fibers)
% Outputs: relmat - reliability matrix
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function relmat = findRel(folder,stimFreq,senFreq,numIter,zcount)

cd(folder)

relmat = zeros(length(stimFreq), length(senFreq), numIter);
colmat = zeros(length(stimFreq), length(senFreq), numIter);
stimat = zeros(length(stimFreq), length(senFreq), numIter);
senmat = zeros(length(stimFreq), length(senFreq), numIter);

for i = 1:length(stimFreq)
    parfor z = 1:length(senFreq)
    sprintf('The location is %dx%d.',i,z)
    address = fullfile('E:\',folder);
    cd(address)
    fldr = strcat('Stim', int2str(stimFreq(i)), 'Sen', int2str(senFreq(z)));
    cd(fldr)
    t = 0:1:numIter-1;
    r_vec = [];
    col_vec_n = []; sti_vec_n = []; 
    sen_vec_n = [];
    for j = 1:numIter
        peak_file = strcat(int2str(t(j)), '.dat');
        peak_mat = dlmread(peak_file, '', 1,0);
        peak_mat = peak_mat(:,1:zcount);
        
        sen_file = strcat(int2str(t(j)), 'Sen.dat');
        sen_vec = dlmread(sen_file);
      
        W = findWaves(peak_mat, zcount);
        [col,sti,sen,~,~] = findEvents(W, peak_mat, zcount);
        
        col_vec_n = [col_vec_n col];
        sti_vec_n = [sti_vec_n sti];
        sen_vec_n = [sen_vec_n sen];
        r_val = sen/length(sen_vec);
        r_vec = [r_vec r_val];
    end
    colmat(i,z,:) = col_vec_n';
    stimat(i,z,:) = sti_vec_n';
    senmat(i,z,:) = sen_vec_n';
    relmat(i,z,:) = r_vec';
    end
end
save('Z:\Cluster_6um_50_30sec\relmat_1.mat', 'relmat');
save('Z:\Cluster_6um_50_30sec\colmat_1.mat', 'colmat');
save('Z:\Cluster_6um_50_30sec\stimat_1.mat', 'stimat');
save('Z:\Cluster_6um_50_30sec\senmat_1.mat', 'senmat');
end