clear;clc;
close all
speed=1000;
load('BackEMF.mat');
data=[CH1,CH2,CH3,CH4,CH5,CH6];
p=3;
f=p*speed/60;
T=1/f;
StartTime=0.4;%提取电流起始时间
DeltaTime=1*1e-6;%时间间隔
StartPoint=StartTime/DeltaTime;%提取电流开始位置
CurrentCycle=1;%提取周期
CurrentPoint=CurrentCycle*T/DeltaTime;%提取电流总数据点数
Time=(0:DeltaTime:CurrentCycle*T)';%时间序列
DataTemp=data(round(StartPoint:length(data)),1);
[Row,Col]=find(DataTemp==min(DataTemp(find(DataTemp>0))));%确定提取电流的起点（0点）位置
ph_a=data(round(StartPoint+Row:StartPoint+Row+CurrentPoint),1);
ph_b=data(round(StartPoint+Row:StartPoint+Row+CurrentPoint),2);
ph_c=data(round(StartPoint+Row:StartPoint+Row+CurrentPoint),3);
ph_d=data(round(StartPoint+Row:StartPoint+Row+CurrentPoint),4);
ph_e=data(round(StartPoint+Row:StartPoint+Row+CurrentPoint),5);
ph_f=data(round(StartPoint+Row:StartPoint+Row+CurrentPoint),6);
DataGet=sign(ph_a(round(CurrentPoint/4)))*[ph_a,ph_b,ph_c,ph_d,ph_e,ph_f];
% ----- 图窗属性设置 -----------------------------------------------
figure
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'Current','white',[500,100,600,350],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ------ Fourier Transfer -----------------------------------------------
% ----- 图形属性设置--------------------------------------------------
h=plot(Time,DataGet);
set(h,'LineWidth',1);
% % ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','DataAspectRatio','xlim','xtick','xticklabel','ylim'};
ValueArrayAx={13.5,'Arial',1,[1 15000 1],[0,CurrentCycle*T],0:0.005:CurrentCycle*T,0:0.005:CurrentCycle*T,[-70,70]};
set(ax,NameArrayAx,ValueArrayAx);
% % ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'Time (s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'Current (A)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location','NumColumns'};
ValueArrayLgd={{'A','B','C','D','E','F'},10,'north',6};
set(lgd,NameArrayLgd,ValueArrayLgd);