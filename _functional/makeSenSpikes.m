%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to make physiological input drawn from poission distribution
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [spikes, len_val_all] = makeSenSpikes(timeStepS, spikesPerS, durationS)

times = [1:timeStepS:durationS];
spikes = zeros(length(spikesPerS), length(times));
vt = rand(size(times));
spikesPerS = spikesPerS(1,:);
for i = 1:length(spikesPerS)
        spikes(i, :) = (spikesPerS(i)*timeStepS) > vt;
        len_val = length(find(spikes(i,:) == 1));
        len_val_all(i) = len_val;
    end
end
