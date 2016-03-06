%% Run to get result
warning off all;
addpath('./minFunc/');
addpath('./source/');
% NewsFeature=load('News');
% NewsFeature = mapminmax(NewsFeature',0,1)';
% CommentsFeature=load('Comment');
% CommentsFeature = mapminmax(CommentsFeature',0,1)';
% LabelFeature=load('Label');
% LabelFeature = LabelFeature(:,2:7)./repmat(LabelFeature(:,1),1,6);
% disp('Load Complete');
load work2
% [L,~] = size(NewsFeature);
% NewsFeature=NewsFeature(1:floor(L/2),:);
% CommentsFeature=CommentsFeature(1:floor(L/2),:);
% LabelFeature=LabelFeature(1:floor(L/2),:);
Part=10;

disp('For News');
%[Lam1]=Instance(NewsFeature,LabelFeature,Part);
Lam1=11;
disp('For Comments');
%[Lam2]=Instance(CommentsFeature,LabelFeature,Part);
Lam2=10;
disp('For Mixture');
Mixture(Lam1,Lam2,NewsFeature,CommentsFeature,LabelFeature,Part);