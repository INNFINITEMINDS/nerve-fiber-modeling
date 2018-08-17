%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to identify the progresssion of particular stimulus along the
% fiber
% Inputs: x - martix of peak values from neuron simulation. e.g. 0.mat
%         zcount - number of nodes (30 - 6um, 21 - 9um, 15 - 12um fibers) 
% Outputs: W - Wave matrix (propagation of each stimulus)
% Coded by: Vijay Sadashivaiah
% Neuromedical Control Systems Lab
% Johns Hopkins University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function W = findWaves(x,zcount)
indw = 1;
x = x(:,1:zcount);
W = zeros(size(x,1),size(x,2));
for i = 1:size(x,1)
    for j = 1:size(x,2)
        if(~isequal(x(i,j),0))
            break
        end
    end
    [X, Y] = find(abs(x - x(i,j)) < 2.0);
    indices = sub2ind(size(W),X,Y);
    W(indices) = indw;
    indw = indw+1;
end
end