function [Omega] = TrainModule(Omega,Feature,Label,Lambda)
% initialize option
options = [];
options.display = 'none';
options.maxFunEvals = 50;
% train
Omega=minFunc(@OmegaFunc,Omega,options,Feature,Label,Lambda);
end