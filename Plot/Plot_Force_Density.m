function []=Plot_Force_Density(F,FourierFr,FourierFt,Time,Space,custom_colormap)
View.TimeOrder=0:24;
View.SpaceOrder=-12:12;
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'3-D waveform of force density','white',[500,100,1000,800],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ================= radial force density ===========================
subplot(2,2,1);
h=surf(Time,Space,F.rad);
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle'};
VlaueArrayGcf={1,'interp','interp','-'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','Box','BoxStyle'};
ValueArrayAx={13.5,'Times New Roman',1,'on','full'};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it t \rm(s)',14,15,[0.01,-70,-100000]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it \theta \rm(\circ)',14,-30,[-0.005,200,-100000]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_r \rm(N/m^2)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
title('Radial force density')
% ====================== tangential force density ====================
subplot(2,2,2);
h=surf(Time,Space,F.tan);
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle'};
VlaueArrayGcf={1,'interp','interp','-'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','Box','BoxStyle'};
ValueArrayAx={13.5,'Times New Roman',1,'on','full'};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it t \rm(s)',14,15,[0.01,-70,-250000]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it \theta \rm(\circ)',14,-30,[-0.005,200,-250000]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_t \rm(N/m^2)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
title('Tangential force density');
% ================= radial force density FFT ========================
subplot(2,2,3);
[~,angle_loc]=ismember(View.SpaceOrder,FourierFr.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierFr.P.TimeOrder);
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierFr.P.Amplitude(angle_loc,time_loc),0.5);
zlim([0 max(max(FourierFr.P.Amplitude))]);
for i = 1:numel(h)
    zData = get(h(i),'ZData');
    zData = repmat(max(zData,[],2),1,4);
    set(h(i),'CData',zData);
    set(h(i),'FaceColor','flat');
end
colormap(custom_colormap{2}(1:end,:));
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','Box','BoxStyle','xlim','xtick','xticklabel'...
    ,'ylim','ytick','yticklabel'};
ValueArrayAx={13.5,'Times New Roman',1,'on','full',[0.5 length(time_loc)+0.5],1:3:length(time_loc),0:3:24,...
    [0.5 length(angle_loc)+0.5],1:3:length(angle_loc),-12:3:12};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it f (\times f_0)',14,15,[18,20,-90000]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it r',14,-30,[1,8,-60000]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_r \rm(N/m^2)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
view(-45,35);
% ================= tangential force density FFT ========================
subplot(2,2,4);
[~,angle_loc]=ismember(View.SpaceOrder,FourierFt.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierFt.P.TimeOrder);
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierFt.P.Amplitude(angle_loc,time_loc),0.5);
zlim([0 max(max(FourierFt.P.Amplitude))]);
for i = 1:numel(h)
    zData = get(h(i),'ZData');
    zData = repmat(max(zData,[],2),1,4);
    set(h(i),'CData',zData);
    set(h(i),'FaceColor','flat');
end
colormap(custom_colormap{2}(1:end,:));
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','Box','BoxStyle','xlim','xtick','xticklabel'...
    ,'ylim','ytick','yticklabel'};
ValueArrayAx={13.5,'Times New Roman',1,'on','full',[0.5 length(time_loc)+0.5],1:3:length(time_loc),0:3:24,...
    [0.5 length(angle_loc)+0.5],1:3:length(angle_loc),-12:3:12};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it f (\times f_0)',14,15,[18,20,-12000]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it r',14,-30,[1,8,-7000]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_t \rm(N/m^2)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
view(-45,35);
end