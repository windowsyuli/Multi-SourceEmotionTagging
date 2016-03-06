MSLR = [0.58305 0.57193	0.5681];
NLR = [0.564 0.55989 0.54259];
CLR = [0.55936 0.55116 0.54186];
% MSLR = [0.73794 0.72934	0.72495];
% NLR = [0.72165 0.71988 0.70763];
% CLR = [0.71966 0.71439 0.70752];


X1=[1 2/3 1/3];
YMatrix1 =[MSLR;NLR;CLR];

figure1 = figure('PaperSize',[20.98404194812 29.67743169791]);

% 创建 axes
axes1 = axes('Parent',figure1,'XTickLabel',{'1/3','2/3','1'},...
    'XTick',[0.3333 0.666 1],...
    'Position',[0.11963589076723 0.13695652173913 0.816644993498049 0.78804347826087],...
    'LineWidth',1.5,...
    'FontSize',16,...
    'FontName','Times New Roman');
%% 取消注释以下行以保留轴的 X 极限
xlim(axes1,[0.25 1.1]);
%% 取消注释以下行以保留轴的 Y 极限
% ylim(axes1,[0.535 0.595]);
box(axes1,'on');
hold(axes1,'all');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X1,YMatrix1,'Parent',axes1,'MarkerEdgeColor','none',...
    'MarkerSize',10,...
    'LineWidth',2);
set(plot1(1),'MarkerFaceColor',[0 0 0],'Marker','^','DisplayName','MSLR',...
    'Color',[0 0 0]);
set(plot1(2),'MarkerEdgeColor',[0 0 1],'Marker','+','LineStyle','--',...
    'DisplayName','NLR');
set(plot1(3),'MarkerFaceColor',[1 0 0],'Marker','o','Color',[1 0 0],...
    'DisplayName','CLR');

% 创建 xlabel
xlabel('Train Ratio','FontSize',16,'FontName','Times New Roman');

% 创建 ylabel
ylabel('MRR','FontSize',16,'FontName','Times New Roman');

% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.200640547002812 0.675640350149355 0.204525357607281 0.190579710144928],...
    'LineWidth',1.5);