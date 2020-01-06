function []=Plot_Lumped_Force(Frz,Ftz,Mrz,Time,TimeStep,ToothAngle,Qs,FourierRad,FourierTan,FourierTq,custom_colormap)
View.TimeOrder=0:36;
View.SpaceOrder=-17:18;
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'3-D waveform of integral force','white',[500,100,1500,800],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ================= radial force ===========================
subplot(2,3,1);
h=surf(Time(1:TimeStep),ToothAngle(1:Qs),Frz);
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
ValueArrayTx={'\it t \rm(s)',14,15,[0.01,-70,-30]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it \theta \rm(\circ)',14,-30,[-0.005,200,-20]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_r \rm(N)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
title('Radial force')
% ================= tangential force ===========================
subplot(2,3,2);
h=surf(Time(1:TimeStep),ToothAngle(1:Qs),Ftz);
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
ValueArrayTx={'\it t \rm(s)',14,15,[0.01,-70,-3]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it \theta \rm(\circ)',14,-30,[-0.005,200,-2]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_t \rm(N)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
title('Tangential force')
% ================= Moment =========================================
subplot(2,3,3);
h=surf(Time(1:TimeStep),ToothAngle(1:Qs),Mrz);
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
ValueArrayTx={'\it t \rm(s)',14,15,[0.01,-70,-0.03]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it \theta \rm(\circ)',14,-30,[-0.005,200,-0.02]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it T \rm(N\cdotm)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
view(-45,40);
title('Moment')
% ================= radial force FFT ========================
subplot(2,3,4);
[~,angle_loc]=ismember(View.SpaceOrder,FourierRad.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierRad.P.TimeOrder);
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierRad.P.Amplitude(angle_loc,time_loc),0.5);
zlim([0 max(max(FourierRad.P.Amplitude))]);
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
ValueArrayAx={13.5,'Times New Roman',1,'on','full',[0.5 length(time_loc)+0.5],1:6:length(time_loc),0:6:36,...
    [0.5 length(angle_loc)+0.5],1:5:length(angle_loc),-17:5:18};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it f (\times f_0)',14,15,[30,25,-75]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it r',14,-30,[1,12,-30]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_r \rm(N)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
view(-45,35);
% ================= Tangential force FFT ========================
subplot(2,3,5);
[~,angle_loc]=ismember(View.SpaceOrder,FourierTan.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierTan.P.TimeOrder);
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierTan.P.Amplitude(angle_loc,time_loc),0.5);
zlim([0 max(max(FourierTan.P.Amplitude))]);
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
ValueArrayAx={13.5,'Times New Roman',1,'on','full',[0.5 length(time_loc)+0.5],1:6:length(time_loc),0:6:36,...
    [0.5 length(angle_loc)+0.5],1:5:length(angle_loc),-17:5:18};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it f (\times f_0)',14,15,[30,25,-6]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it r',14,-30,[1,12,-2]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it F_t \rm(N)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
view(-45,35);
% ================= Moment FFT ========================
subplot(2,3,6);
[~,angle_loc]=ismember(View.SpaceOrder,FourierTq.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierTq.P.TimeOrder);
% ----- 图形属性设置-----------------------------------------
h=bar3(FourierTq.P.Amplitude(angle_loc,time_loc),0.5);
zlim([0 max(max(FourierTq.P.Amplitude))]);
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
ValueArrayAx={13.5,'Times New Roman',1,'on','full',[0.5 length(time_loc)+0.5],1:6:length(time_loc),0:6:36,...
    [0.5 length(angle_loc)+0.5],1:5:length(angle_loc),-17:5:18};
set(ax,NameArrayAx,ValueArrayAx);
% ----- 坐标轴标签设置 --------------------------------------
label.tx=xlabel('');
NameArrayTx={'String','FontSize','Rotation','Position'};
ValueArrayTx={'\it f (\times f_0)',14,15,[30,25,-0.03]};
set(label.tx,NameArrayTx,ValueArrayTx);
label.ty=ylabel('');
NameArrayTy={'String','FontSize','Rotation','Position'};
ValueArrayTy={'\it r',14,-30,[1,12,-0.01]};
set(label.ty,NameArrayTy,ValueArrayTy);
label.tz=zlabel('');
NameArrayTz={'String','FontSize'};
ValueArrayTz={'\it T \rm(N\cdotm)',14};
set(label.tz,NameArrayTz,ValueArrayTz);
label.cb=colorbar;
NameArrayCb={'LineWidth','FontSize','Visible','Location'};
ValueArrayCb={0.5,13,'off','north'};
set(label.cb,NameArrayCb,ValueArrayCb);
view(-45,35);
end