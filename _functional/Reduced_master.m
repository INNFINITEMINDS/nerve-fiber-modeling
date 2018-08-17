%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to compute relay reliability using the reduced model parameters 
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f_stim1 = 1:4:51; %Stimulus frequency
f_sen1 = 1:4:51; %Physiological input frequency 
timeStepS = 0.000001;  % Resoultion of time slice
NumIter = 50; % Number of iterations for reliability by simulation
DurVal = 30;

[f_stim,f_sen] = ndgrid(f_stim1,f_sen1); % Createing a 2D grid to simulate on all frequencies
t_stim1 = 1./f_stim; 

r12 = 0.0096; % phys - stim loss
r21 = 0.0043; % stim - phys loss
r22 = 0.0085; % stim - stim loss
r11 = 0.0032; % phys - phys loss
l = 0.1; % Length of nerve fibre
c = (10*4.17); % Speed of AP conduction

a = (2*l)/c;
%% Reliability by Simulation

% Define various interaction parameters
rval_mat = zeros(length(f_stim1),length(f_sen1),NumIter);
rval_stim = zeros(length(f_stim1),length(f_sen1),NumIter);
colmat = zeros(length(f_stim1),length(f_sen1),NumIter);
senstimmat = zeros(length(f_stim1),length(f_sen1),NumIter);
stimsenmat = zeros(length(f_stim1),length(f_sen1),NumIter);
sensenmat = zeros(length(f_stim1),length(f_sen1),NumIter);
stimstimmat = zeros(length(f_stim1),length(f_sen1),NumIter);

for z = 1:NumIter % For each iteraction count
    [sen_spikes, len_val] = makeSenSpikes(timeStepS, f_sen(1,:), DurVal); % Make the physiological input
    stim_spikes = makeStimSpikes(timeStepS, f_stim(:,1), DurVal); % Make the stimulus input
    for i = 1:length(f_stim1)
        tval_stim = stim_spikes{i};
        for j = 1:length(f_sen1)
            tval_sen = timeStepS*(find(squeeze(sen_spikes(j,:))));
            len_stim = length(tval_stim);
            [times_top,count] = simplemodel_fast2(tval_sen,tval_stim,c,l,r21,r12,r22,r11); % Find interactions
            
            rval_mat(i,j,z) = (len_val(j) - count.Col - count.StimSens-count.SensSens)/(len_val(j)); % relay phys
            rval_stim(i,j,z) = (len_stim - count.Col - count.StimStim-count.SensStim)/len_stim; % relay stim
            colmat(i,j,z) = count.Col;
            sensenmat(i,j,z) = count.SensSens;
            senstimmat(i,j,z) = count.SensStim;
            stimsenmat(i,j,z) = count.StimSens;
            stimstimmat(i,j,z) = count.StimStim;
        end
    end
    display(z,'This is my loop');
end

% Save the interaction matrices in the current directory
save('relmat_sim_6um.mat','rval_mat');
save('relmat_stim_6um.mat','rval_stim');
save('sensenmat_6um.mat','sensenmat');
save('colmat_6um.mat','colmat');
save('senstimmat_6um.mat','senstimmat');
save('stimsenmat_6um.mat','stimsenmat');
save('stimstimmat_6um.mat','stimstimmat');
