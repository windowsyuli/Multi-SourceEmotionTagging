function [MatrixTrain,MatrixTest]=GetPart(Matrix,PartIndex,Part)% PartIndex=1:1:Part
[Length,~]=size(Matrix);
Base=Length/Part;
Index1 = [1:floor(Base*(PartIndex-1)) 1+floor(Base*PartIndex):Length];
Index2 = (1+floor(Base*(PartIndex-1))):floor(Base*PartIndex);
MatrixTrain=Matrix(Index1,:);
MatrixTest=Matrix(Index2,:);
end