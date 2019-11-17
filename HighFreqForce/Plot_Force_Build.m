function [angle_loc]=Plot_Force_Build(FourierFr_100,FourierFt_100,FourierFr_1000,FourierFt_1000,Time,Space)
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,1200,300],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
View.SpaceOrder=-36:6:36;
[angle_tf,angle_loc]=ismember(View.SpaceOrder,FourierFr_1000.P.SpaceOrder);
subplot(1,2,1)
h=bar([FourierFr_1000.P.Amplitude(angle_loc,20),FourierFr_100.P.Amplitude(angle_loc,2)]);% time order: f/f0+1
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',1;'k',1};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','xtick','xticklabel'};
ValueArrayAx={13.5,'Times New Roman',1,[0.5 length(angle_loc)+0.5],1:1:length(angle_loc),-36:6:36};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it r',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it \sigma_r \rm(N/m^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'current 1000Hz force 950Hz','current 100Hz force 50Hz'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);

subplot(1,2,2)
h=bar([FourierFt_1000.P.Amplitude(angle_loc,20),FourierFt_100.P.Amplitude(angle_loc,2)]);% time order: f/f0+1
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',1;'k',1};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(h,NameArrayFig,ValueArrayFig)
% ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','xtick','xticklabel'};
ValueArrayAx={13.5,'Times New Roman',1,[0.5 length(angle_loc)+0.5],1:1:length(angle_loc),-36:6:36};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it r',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it \sigma_t \rm(N/m^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'current 1000Hz force 950Hz','current 100Hz force 50Hz'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
end