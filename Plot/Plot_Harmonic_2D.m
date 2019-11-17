function []=Plot_Harmonic_2D(Br,Bt,F,Time,TimeStep,Space,AngleStep,f0)
[FourierB]=FFT_fun([Br(1:AngleStep,1),Bt(1:AngleStep,1)],Space(1:AngleStep),1,f0,1,'1D','fun');
[FourierF]=FFT_fun([F.rad(1:AngleStep,1),F.tan(1:AngleStep,1)],Space(1:AngleStep),1,f0,1,'1D','fun');
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'Harmonics of flux and force','white',[500,100,900,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
%% flux density
% ----- 图形属性设置--------------------------------------------------
subplot(2,2,1)
h=plot(Space(1:AngleStep)',[Br(1:AngleStep,1),Bt(1:AngleStep,1)]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-','r';
    1.5,'none','-','k'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0 360],[-1.5,1.5]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it \theta \rm(\circ)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it B \rm(T)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'\it B_r','\it B_t'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
% =============== harmonic analysis ================================
subplot(2,2,3)
h=bar(FourierB.P.Order(1:26)',FourierB.P.Amplitude(1:26,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',0.8;'k',0.8};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0,1]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Order',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it B \rm(T)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'\it B_r','\it B_t'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
%% force density
% ----- 图形属性设置--------------------------------------------------
subplot(2,2,2)
h=plot(Space(1:AngleStep)',[F.rad(1:AngleStep,1),F.tan(1:AngleStep,1)]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-','r';
    1.5,'none','-','k'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0 360],[-10000,700000]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it \theta \rm(\circ)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it F \rm(N/m^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'\it F_r','\it F_t'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
% =============== harmonic analysis ================================
subplot(2,2,4)
h=bar(FourierF.P.Order(1:26)',FourierF.P.Amplitude(1:26,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',0.8;'k',0.8};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={13.5,'Times New Roman',1,[0,200000]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Order',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it F \rm(N/m^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'\it F_r','\it F_t'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
end