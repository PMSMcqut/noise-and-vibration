function []=Plot_Force_Validate(ForceJmag,ForceIntegral,Time,TimeStep,ToothAngle,Qs,f0)
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'Integral force validation','white',[500,100,1200,600],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
TimeJmag=0:max(Time)/(length(ForceJmag.rad(:,1))-1):max(Time);
%% Radial force
% ----- 图形属性设置--------------------------------------------------
subplot(3,2,1)
h=plot(Time(1:TimeStep)',ForceIntegral.rad(1,1:TimeStep)',TimeJmag(1:length(ForceJmag.rad(:,1))-1),ForceJmag.rad(1:length(ForceJmag.rad(:,1))-1,1));
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-.','b';
    1.5,'none','-','r'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[-5,270]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Time \rm(s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it F_r \rm(N)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Integral','FEA-JMAG'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
% =============== harmonic analysis ================================
[FourierFr]=FFT_fun([ForceIntegral.rad(1,1:TimeStep)',ForceJmag.rad(1:TimeStep,1)],Time(1:TimeStep),ToothAngle(1:Qs),f0,5000,'1D','fun');
% ----- 图形属性设置--------------------------------------------------
subplot(3,2,2)
h=bar(FourierFr.P.Order(150:170)',FourierFr.P.Amplitude(150:170,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'b',0.8;'r',0.8};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0,1.5]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it f (\times f_0)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it F_r \rm(N)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Integral','FEA-JMAG'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
%% tangential force
% ----- 图形属性设置--------------------------------------------------
subplot(3,2,3)
h=plot(Time(1:TimeStep)',ForceIntegral.tan(1,1:TimeStep)',TimeJmag(1:length(ForceJmag.tan(:,1))-1),ForceJmag.tan(1:length(ForceJmag.tan(:,1))-1,1));
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-.','b';
    1.5,'none','-','r'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig);
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[-2,25]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Time \rm(s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it F_t \rm(N)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Integral','FEA-JMAG'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
% =============== harmonic analysis ================================
[FourierFt]=FFT_fun([ForceIntegral.tan(1,1:TimeStep)',ForceJmag.tan(1:TimeStep,1)],Time(1:TimeStep),ToothAngle(1:Qs),f0,5000,'1D','fun');
% ----- 图形属性设置--------------------------------------------------
subplot(3,2,4)
h=bar(FourierFt.P.Order(150:170)',FourierFt.P.Amplitude(150:170,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'b',0.8;'r',0.8};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0,0.5]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it f (\times f_0)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it F_t \rm(N)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Integral','FEA-JMAG'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
%% Moment
% ----- 图形属性设置--------------------------------------------------
subplot(3,2,5)
h=plot(Time(1:TimeStep)',ForceIntegral.tq(1,1:TimeStep)',TimeJmag(1:length(ForceJmag.tq(:,1))-1),ForceJmag.tq(1:length(ForceJmag.tq(:,1))-1,1));
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-.','b';
    1.5,'none','-','r'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[-0.02,0.12]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Time \rm(s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it T \rm(N\cdotm)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Integral','FEA-JMAG'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
% =============== harmonic analysis ================================
[FourierM]=FFT_fun([ForceIntegral.tq(1,1:TimeStep)',ForceJmag.tq(1:TimeStep,1)],Time(1:TimeStep),ToothAngle(1:Qs),f0,5000,'1D','fun');
% ----- 图形属性设置--------------------------------------------------
subplot(3,2,6)
h=bar(FourierM.P.Order(150:170)',FourierM.P.Amplitude(150:170,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'b',0.8;'r',0.8};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0,0.02]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it f (\times f_0)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it T \rm(N\cdotm)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Integral','FEA-JMAG'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
end