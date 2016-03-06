function Mixture(Lam1,Lam2,NewsFeature,CommentsFeature,LabelFeature,Part)
[~,LabelCount]=size(LabelFeature);
OmegaInit=normrnd(0,0,LabelCount*(LabelCount*2+1),1);
MaxLam=0;
MaxAccu=0;
for Lambda=6
    AccuracyAll = zeros(LabelCount,1);
    MRRAll=0;
    for i=1:Part
        Omega = OmegaInit;
        [LabelTrain,LabelTest]=GetPart(LabelFeature,i,Part);
        [NewsPred,TestNewsPred]=GetPred(NewsFeature,LabelFeature,Lam1,i,Part);
        [CommentsPred,TestCommentsPred]=GetPred(CommentsFeature,LabelFeature,Lam2,i,Part);
        [TrainLength,~]=size(NewsPred);
        [TestLength,~]=size(TestNewsPred);
        FeatureTrain=[ones(TrainLength,1) NewsPred CommentsPred];
        FeatureTest=[ones(TestLength,1) TestNewsPred TestCommentsPred];
        [L,~] = size(FeatureTrain);L=1:floor(L/3*3);
        Omega = TrainModule(Omega,FeatureTrain(L,:),LabelTrain(L,:),exp(Lambda));
        [Accuracy,MRR,~] = TestModule(Omega,FeatureTest,LabelTest);
        AccuracyAll=AccuracyAll+Accuracy;
        MRRAll=MRRAll+MRR;
    end
    AccuracyAll=AccuracyAll/Part;
    MRRAll=MRRAll/Part;
    disp(strcat('Lambda: ',num2str(Lambda),' Accu: ',num2str(AccuracyAll(1,1)),' MRR: ',num2str(MRRAll)));
    if AccuracyAll(1)>MaxAccu
        MaxAccu=AccuracyAll;
        MaxLam=Lambda;
    end
end
disp(strcat('Best is Accu: ',num2str(MaxAccu),' Lambda: ',num2str(MaxLam)));
end

function [Y,TestY]=GetPred(Feature,Label,Lambda,part,Part)
[Feature,FeatureTest]=GetPart(Feature,part,Part);
[Label,~]=GetPart(Label,part,Part);
% initialize parameter
[DocumentCount,FeatureCount]=size(Feature);% return DocumentCount * FeatureCount
[DocumentCountTest,~]=size(FeatureTest);
[~,LabelCount]=size(Label);% return DocumentCount * LabelCount
Feature=[ones(DocumentCount,1),Feature];
FeatureTest=[ones(DocumentCountTest,1),FeatureTest];
Omega=normrnd(0,1,LabelCount*(FeatureCount+1),1);
Omega=TrainModule(Omega,Feature,Label,exp(Lambda));
Omega=reshape(Omega,FeatureCount+1,LabelCount);
Y=LogisticRegression(Feature,Omega,LabelCount);
TestY=LogisticRegression(FeatureTest,Omega,LabelCount);
end
function [Y]=LogisticRegression(Feature,Omega,LabelCount)
ExpFO=exp(Feature*Omega);
ExpSum = repmat(sum(ExpFO,2),1,LabelCount);
Y = ExpFO./ExpSum;
end