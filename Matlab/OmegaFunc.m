function [Func,Grad] = OmegaFunc(Omega,Feature,Label,Lambda)

% Initialize parameter
[~,FeatureCount]=size(Feature);% return DocumentCount * FeatureCount
[~,LabelCount]=size(Label);% return DocumentCount * LabelCount
Omega=reshape(Omega,FeatureCount,LabelCount);

% Logistic part
ExpFO=exp(Feature*Omega);
ExpSum = repmat(sum(ExpFO,2),1,LabelCount);
Y = ExpFO./ExpSum;

% L2 regularization
Penalty = Omega.^2;
Penalty = sum(sum(Penalty,1),2);
Penalty = Lambda*Penalty/(LabelCount*FeatureCount);

% Calculation of negative log-likelihood
Func = -sum(sum(Label.*log(Y),1),2)+Penalty;

% Calculation of firstoder-derivative
Grad = (Label-Y)'*Feature;
Grad = -Grad'+2*Omega*Lambda/(LabelCount*FeatureCount);
Grad = reshape(Grad,FeatureCount*LabelCount,1);

end