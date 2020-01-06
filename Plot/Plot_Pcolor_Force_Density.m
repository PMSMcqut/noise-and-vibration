function []=Plot_Pcolor_Force_Density(F,FourierFr,FourierFt,Time,Space,custom_colormap)
View.TimeOrder=0:36;
View.SpaceOrder=-12:12;
[~,angle_loc]=ismember(View.SpaceOrder,FourierFr.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierFr.P.TimeOrder);
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'3-D waveform of force density','white',[500,100,1400,500],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
subplot(1,2,1)
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierFr.P.Amplitude(angle_loc,time_loc),2);
zlim([0 max(max(FourierFr.P.Amplitude))]);
for i = 1:numel(h)
    zData = get(h(i),'ZData');
    zData = repmat(max(zData,[],2),1,4);
    set(h(i),'CData',zData);
    set(h(i),'FaceColor','flat','EdgeColor','none','FaceAlpha',0.6);
end
% ------ 颜色图属性 ----------------------------------------
colormap(custom_colormap{3}(1:end,:));
% caxis([0 1]);%调整colorbar的颜色范围
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','Box','BoxStyle','xlim','xtick','xticklabel'...
    ,'ylim','ytick','yticklabel','DataAspectRatio'};
ValueArrayAx={13.5,'Times New Roman',1,'off','back',[0 length(time_loc)+1],1:2:length(time_loc),0:2:36,...
    [0 length(angle_loc)+1],1:3:length(angle_loc),-12:3:12,[1 1.2 1]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 网格属性设置 ----------------------------------------
gd=gca;
NameArrayAx={'XGrid','YGrid','Layer','GridLineStyle','GridColor','GridAlpha'};
ValueArrayAx={'on','on','top','--',[0.5 0.5 0.5],0.3};
set(gd,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation'};
ValueArrayTx={['Temporal order','\it u'],14,0};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation'};
ValueArrayTy={['Spatial order','\it v'],14,90};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_r \rm(N/m^2)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar();
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'on','eastoutside'};
set(label.cb,NameArrayCb,ValueArrayCb);
label.cb.Label.String=['Radial force density','\rm (N/m^2)'];
view(0,90);
hold on
hh=line([0 length(time_loc)+1],[floor(length(View.SpaceOrder)/2)+1 floor(length(View.SpaceOrder)/2)+1]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={2,'none','--','k'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(hh,NameArrayFig,ValueArrayFig);
subplot(1,2,2)
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierFt.P.Amplitude(angle_loc,time_loc),2);
zlim([0 max(max(FourierFt.P.Amplitude))]);
for i = 1:numel(h)
    zData = get(h(i),'ZData');
    zData = repmat(max(zData,[],2),1,4);
    set(h(i),'CData',zData);
    set(h(i),'FaceColor','flat','EdgeColor','none','FaceAlpha',0.6);
end
% ------ 颜色图属性 ----------------------------------------
colormap(custom_colormap{3}(1:end,:));
% caxis([0 1]);%调整colorbar的颜色范围
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','Box','BoxStyle','xlim','xtick','xticklabel'...
    ,'ylim','ytick','yticklabel','DataAspectRatio'};
ValueArrayAx={13.5,'Times New Roman',1,'off','back',[0 length(time_loc)+1],1:2:length(time_loc),0:2:36,...
    [0 length(angle_loc)+1],1:3:length(angle_loc),-12:3:12,[1 1.2 1]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 网格属性设置 ----------------------------------------
gd=gca;
NameArrayAx={'XGrid','YGrid','Layer','GridLineStyle','GridColor','GridAlpha'};
ValueArrayAx={'on','on','top','--',[0.5 0.5 0.5],0.3};
set(gd,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation'};
ValueArrayTx={['Temporal order','\it u'],14,0};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation'};
ValueArrayTy={['Spatial order','\it v'],14,90};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_r \rm(N/m^2)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar();
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'on','eastoutside'};
set(label.cb,NameArrayCb,ValueArrayCb);
label.cb.Label.String=['tangential force density','\rm (N/m^2)'];
view(0,90);
hold on
hh=line([0 length(time_loc)+1],[floor(length(View.SpaceOrder)/2)+1 floor(length(View.SpaceOrder)/2)+1]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={2,'none','--','k'};% 行数代表了图形中的有几个绘图的对象，列数代表了每个对象有几个属性
set(hh,NameArrayFig,ValueArrayFig);
end