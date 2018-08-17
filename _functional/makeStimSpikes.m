%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to make extracellular stimulus
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function spikes = makeStimSpikes(timeStepS, spikesPerS, durationS)

times = 0:timeStepS:durationS;
time_val_all = zeros(length(spikesPerS), length(times));
for i = 1:length(spikesPerS)
        time_val = 1:1/spikesPerS(i):(durationS);
        spikes{i} = time_val;
end
