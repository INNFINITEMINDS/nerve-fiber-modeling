%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to identify the different interaction type from the full model
% Inputs: W - Wave matrix (Propagation of each stimulus)
%         x - martix of peak values from neuron simulation. e.g. 0.mat  
%         zcount - number of nodes (30 - 6um, 21 - 9um, 15 - 12um fibers)
% Outputs: col, sti, sen, err - Type of interaction
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [col,sti,sen,err,label,labelt] = findEvents(W,x,zcount)

z  = 1:zcount;

Ncol = 0;
Nsti = 0;
Nsen = 0;
Err_cnt = 0;
x = x(:,1:zcount);
label =zeros(length(x),1);
labelt = zeros(length(x),1);
for ii = 1:max(W(:))
    indj = x(W == ii);
    indi = z';
    if length(indj) == zcount
        A = [indi indj];
        A = sortrows(A,1);
        [fitresult, ~] = createFit(A(:,2), A(:,1));
        [~, indc] = findpeaks(A(:,2), A(:,1));
        if ~isempty(indc)
            Ncol = Ncol + 1;
            label(ii) = 1;
            labelt(ii) = indj(1);
        elseif (fitresult.p1 < 0)
            Nsti = Nsti + 1;
            label(ii) = 2;
            labelt(ii) = indj(end);
        elseif (fitresult.p1 > 0)
            Nsen = Nsen + 1;
            label(ii) = 3;
            labelt(ii) = indj(1);
        else
            Err_cnt = Err_cnt+1;
        end
    end
end

col = Ncol;
sti = Nsti;
sen = Nsen;
err = Err_cnt;
end