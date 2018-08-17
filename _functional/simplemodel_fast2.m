%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to identify the different collision type
% Inputs: times_sen, times_stim - Time indices of physiological and
%         stimulus inputs
%         c - speed of conduction, l - length of fiber  
%         r_stim_sens,r_sens_stim,r_stim_stim,r_sens_sens - refractory
%         periods
% Outputs: times_top - Time taken to reach the top of fiber
%          count - struct with the count of different interactions
% Coded by: Vijay Sadashivaiah and Pierre Sacré
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [times_top,count] = simplemodel_fast2(times_sen,times_sti,c,l,r_stim_sens,r_sens_stim,r_stim_stim,r_sens_sens)

times = [times_sen,times_sti];
types = [1*ones(size(times_sen)),2*ones(size(times_sti))];


[times,I] = sort(times);
types     = types(I);


countCol = 0;
countSensSens = 0;
countSensStim = 0;
countStimStim = 0;
countStimSens = 0;

jj = 1;
while jj <= length(times),
    
    switch types(jj),
        case 1, % sens
            
            % sens-sens interaction
            indSensSens = (types == 1) & ( (times(jj) < times) & (times <= times(jj)+r_sens_sens) );
            if any( indSensSens ),
                times = times(~indSensSens);
                types = types(~indSensSens);
                countSensSens = countSensSens + sum(indSensSens);
            end
            
            % sens-stim interaction
            indSensStim = (types == 2) & ( (times(jj)+l/c < times) & (times <= times(jj)+l/c+r_sens_stim) );
            if any( indSensStim ),
                times = times(~indSensStim);
                types = types(~indSensStim);
                countSensStim = countSensStim + sum(indSensStim);
            end            
        case 2, % stim
            
            % stim-stim
            indStimStim = (types == 2) & ( (times(jj) < times) & (times <= times(jj)+r_stim_stim) );
            if any( indStimStim ),
                times = times(~indStimStim);
                types = types(~indStimStim);
                countStimStim = countStimStim + sum(indStimStim);
            end
            
            % stim-sens
            indStimSens = (types == 1) & ( (times(jj)+l/c < times) & (times <= times(jj)+l/c+r_stim_sens) );
            if any( indStimSens ),
                times = times(~indStimSens);
                types = types(~indStimSens);
                countStimSens = countStimSens + sum(indStimSens);
            end
            
            % collision
            indCol = (types == 1) & ( (times(jj)-l/c < times) & (times <= times(jj)+l/c) );
            if any( indCol ),
                ind = find(indCol,1,'first');
                times(ind) = [];
                types(ind) = [];
                countCol = countCol + 1;
            end
            
    end
    
    jj = jj + 1;
    
end

count.Col = countCol;
count.SensSens = countSensSens;
count.SensStim = countSensStim;
count.StimSens = countStimSens;
count.StimStim = countStimStim;

times_top = times(types == 1) - l/c;
