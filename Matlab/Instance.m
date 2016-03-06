function[MaxLam]=Instance(Feature,Label,Cross)
[DocumentCount,FeatureCount]=size(Feature);% return DocumentCount * FeatureCount
[~,LabelCount]=size(Label);% return DocumentCount * LabelCount
Feature=[ones(DocumentCount,1),Feature];
OmegaInit = normrnd(0,1,LabelCount*(FeatureCount+1),1);
MaxLam=0;
MaxAccu=0;
for Lambda=9
    AccuracyAll = zeros(LabelCount,1);
    MRRAll=0;
    for i=1:Cross
        Omega = OmegaInit;
        [FeatureTrain,FeatureTest]=GetPart(Feature,i,Cross);
        [LabelTrain,LabelTest]=GetPart(Label,i,Cross);
        [L,~] = size(FeatureTrain);L=1:floor(L/3*2);
        Omega = TrainModule(Omega,FeatureTrain(L,:),LabelTrain(L,:),exp(Lambda));
        [Accuracy,MRR,~] = TestModule(Omega,FeatureTest,LabelTest);
        AccuracyAll=AccuracyAll+Accuracy;
        MRRAll=MRRAll+MRR;
    end
    AccuracyAll=AccuracyAll/Cross;
    MRRAll=MRRAll/Cross;
    disp(strcat('Lambda: ',num2str(Lambda),' Accu: ',num2str(AccuracyAll(1,1)),' MRR: ',num2str(MRRAll)));
    if AccuracyAll(1)>MaxAccu
        MaxAccu=AccuracyAll(1);
        MaxLam=Lambda;
    end
end
disp(strcat('Best is Accu: ',num2str(MaxAccu),' Lambda: ',num2str(MaxLam)));
end