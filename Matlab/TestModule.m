function [Accuracy,MRR,Predict] = TestModule(Omega, Feature, Label)

% Initialize parameter
[DocumentCount,FeatureCount]=size(Feature);% return DocumentCount * FeatureCount
[~,LabelCount]=size(Label);% return DocumentCount * LabelCount
Omega = reshape(Omega,FeatureCount,LabelCount);

AccuCount=zeros(LabelCount, 1);
Accuracy = zeros(LabelCount,1);
MRR=0;

EepFO =exp(Feature * Omega);
ExpSum = repmat(sum(EepFO,2),1,LabelCount);
Predict = EepFO./ExpSum;

% Calculation of Evaluation
for i=1:DocumentCount 
    [~,LabelIndex]=sort(Label(i,:),'descend');
    [~,PredictIndex]=max(Predict(i,:));
    for j=1:LabelCount
        if LabelIndex(j)==PredictIndex;
            AccuCount(j) = AccuCount(j)+1;
            MRR = MRR + 1.0/j;
            break;
        end
    end
end

MRR = MRR/DocumentCount;


for j = 1:LabelCount
    for k = 1:j
        Accuracy(j)=Accuracy(j)+AccuCount(k);
    end
    Accuracy(j)=Accuracy(j)/DocumentCount;
end

end