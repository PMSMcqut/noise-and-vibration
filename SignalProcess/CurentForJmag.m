clear;clc;
close all
speed=300:100:1500;
for i=1:length(speed)
    load(['load9.6Nm',num2str(speed(i)),'rpm.mat']);
    current=[CH1,CH2,CH3,CH4];
    p=3;
    rpm=speed(i);
    f=p*rpm/60;
    T=1/f;
    StartTime=0.4;%提取电流起始时间
    DeltaTime=1*1e-6;%时间间隔
    StartPoint=StartTime/DeltaTime;%提取电流开始位置
    CurrentCycle=1;%提取周期
    CurrentPoint=CurrentCycle*T/DeltaTime;%提取电流总数据点数
    Time=(0:DeltaTime:CurrentCycle*T)';%时间序列
    CurrentTemp=current(round(StartPoint:length(current)),1);
    [Row,Col]=find(CurrentTemp==min(CurrentTemp(find(CurrentTemp>0))));%确定提取电流的起点（0点）位置
    DeltaPhase=1/3*T/(DeltaTime);%两相电流相位差
    Ia=current(round(StartPoint+Row:StartPoint+Row+CurrentPoint),1);
    Ib=current(round(StartPoint+Row:StartPoint+Row+CurrentPoint),2);
    Ic=current(round(StartPoint+Row:StartPoint+Row+CurrentPoint),3);
    
    % Ic=current(round(StartPoint+Row-2*DeltaPhase:StartPoint+Row-2*DeltaPhase+CurrentPoint),1);
    Id=current(round(StartPoint+Row:StartPoint+Row+CurrentPoint),4);
    Ie=current(round(StartPoint+Row-1*DeltaPhase:StartPoint+Row-1*DeltaPhase+CurrentPoint),4);
    If=current(round(StartPoint+Row-2*DeltaPhase:StartPoint+Row-2*DeltaPhase+CurrentPoint),4);
    
    CurrentJmag=sign(Ia(round(CurrentPoint/4)))*[Ia,Ib,Ic,Id,Ie,If];
    I_harm{i}=double(CurrentJmag);
% ----- 图窗属性设置 -----------------------------------------------
% figure(i)
% 
% fig=gcf;
% NameArrayGcf={'Name','color','position','Units'};
% VlaueArrayGcf={'Current','white',[500,100,800,500],'centimeters'};
% set(fig,NameArrayGcf,VlaueArrayGcf);
% % ------ Fourier Transfer -----------------------------------------------
% % ----- 图形属性设置--------------------------------------------------
% h=plot(Time,CurrentJmag);
% set(h,'LineWidth',1);
% % % ----- 坐标轴属性设置 ----------------------------------------------------
% ax=gca;
% NameArrayAx={'FontSize','FontName','LineWidth','DataAspectRatio','xlim','xtick','xticklabel','ylim'};
% ValueArrayAx={13.5,'Times New Roman',1,[1 1000 1],[0,CurrentCycle*T],0:0.02:CurrentCycle*T,0:0.02:CurrentCycle*T,[-20,20]};
% set(ax,NameArrayAx,ValueArrayAx);
% % % ----- 坐标轴标签设置 ----------------------------------------------------
% tx=xlabel('');
% NameArrayTx={'String','FontSize'};
% ValueArrayTx={'\it t \rm(s)',14};
% set(tx,NameArrayTx,ValueArrayTx);
% ty=ylabel('');
% NameArrayTy={'String','FontSize'};
% ValueArrayTy={'\it I_{ph} \rm(A)',14};
% set(ty,NameArrayTy,ValueArrayTy);
% % ----- 图例设置 ---------------------------------------------------------
% lgd=legend;
% NameArrayLgd={'String','FontSize','Location'};
% ValueArrayLgd={{'Phase A','Phase B','Phase C','Phase D','Phase E','Phase F'},12,'northeast'};
% set(lgd,NameArrayLgd,ValueArrayLgd);
end