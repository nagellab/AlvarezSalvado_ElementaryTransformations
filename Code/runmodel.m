
function [out, matrix] = runmodel (triallength, environment, ntrials, range1, range2)

% This program is used series of simulations of the computational
% navigation model, in which two variables (range1 and range2) are
% sistematically changed in every simulation.
%
% It needs to call a function that takes two extra arguments and in which
% code those arguments have been explicitly located (e.g. in OFFscale,
% Kbin, wind speed, etc.). This needs to be done manually but it's easy.


tic
n = 1;

for i = range1 % Iterates through each pair of parameters
    for j = range2
           
        % Calls the model to run one simulation with the current pair of
        % parameters. Make sure it calls your desired model function.
        results = Elifenavmodel_binaral_local(triallength, environment,0,ntrials,i,j);
        
        % It saves the current values of the two parameters in the results
        % structure.
        results.OFF = i;
        results.Kbin = j;
        
        out(n) = results; % Saves results

    n = n+1;
    end
end
toc

% Produces a single matrix with each success rate generated by the model.
% This matrix is returned as an optional output argument and can be
% represented directly with 'imagesc'. The values corresponding to "range1"
% will be in the Y axis and the values from "range2" will be in the X axis.
% Note that the 'imagesc' function represents the Y axis from top to
% bottom.
n = 1;
for on=1:length(range1)
    for off=1:length(range2)
        matrix(on,off) = out(n).successrate;
        n = n+1;
    end
end

