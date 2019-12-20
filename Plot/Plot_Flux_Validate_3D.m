close all
clear;clc;
load('Bg_load_500.mat');
load('Bg_frm_sin500.mat');
load('custom_colormap.mat');
% ====================== flux density ==============================
TimeStep=200;
AngleStep=360;
Time=0:1/25/TimeStep:1/25;% Time for FFT
Space=0:360/AngleStep:360;
TimeDomain.Time=Time(1:TimeStep);
TimeDomain.Space=Space(1:AngleStep);% Space angle for FFT
[FourierBgFRM.rad]=FFT_fun(Bg.rad(1:TimeStep,1:AngleStep/3)',TimeDomain.Time,TimeDomain.Space(1:120),25,5000,'2D','fun');
[FourierBgFRM.tan]=FFT_fun(Bg.tan(1:TimeStep,1:AngleStep/3)',TimeDomain.Time,TimeDomain.Space(1:120),25,5000,'2D','fun');
[FourierBgFEM.rad]=FFT_fun(Bg_load.rad(1:AngleStep/3,1:TimeStep),TimeDomain.Time,TimeDomain.Space(1:120),25,5000,'2D','fun');
[FourierBgFEM.tan]=FFT_fun(Bg_load.tan(1:AngleStep/3,1:TimeStep),TimeDomain.Time,TimeDomain.Space(1:120),25,5000,'2D','fun');
%% ================= radial flux density ===========================
figure(1)
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);

h=surf(Time,Space(1:end),Bg.rad(:,1:end)');
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','Marker'};
VlaueArrayGcf={0.5,'interp','interp','-','none'};
set(h,NameArrayGcf,VlaueArrayGcf);
hold on
[x,y]=meshgrid(Time,Space(1:end));
time_reshape=reshape(x,1,[]);
space_reshape=reshape(y,1,[]);
Br_reshape=reshape(Bg.rad(:,1:end)',1,[]);
h2=scatter3(time_reshape,space_reshape,Br_reshape,30,'Marker','.','MarkerEdgeColor','#1976D2','LineWidth',0.5,'MarkerFaceAlpha',1);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'ylim','ytick','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0,0.04],0:0.01:0.04,[0,360],0:60:360,[-1.2,1.2],-1.2:0.6:1.2};
set(ax,NameArrayAx,ValueArrayAx);
legend({'FRM','FEM'},'Position',[0.7,0.6,0.1,0.1])
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
%% ================= tangential flux density ===========================
figure(2)
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);

h=surf(Time,Space(1:end),Bg.tan(:,1:end)');
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','Marker'};
VlaueArrayGcf={0.5,'interp','interp','-','none'};
set(h,NameArrayGcf,VlaueArrayGcf);
hold on
[x,y]=meshgrid(Time,Space(1:end));
time_reshape=reshape(x,1,[]);
space_reshape=reshape(y,1,[]);
Bt_reshape=reshape(Bg.tan(:,1:end)',1,[]);
h2=scatter3(time_reshape,space_reshape,Bt_reshape,30,'Marker','.','MarkerEdgeColor','#1976D2','LineWidth',0.5,'MarkerFaceAlpha',1);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'ylim','ytick','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0,0.04],0:0.01:0.04,[0,360],0:60:360,[-0.4,0.4],-0.4:0.2:0.4};
set(ax,NameArrayAx,ValueArrayAx);
legend({'FRM','FEM'},'Position',[0.7,0.6,0.1,0.1])
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
% ======================== FFT, Radial=================================
figure(3)
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
View.TimeOrder=0:12;
View.SpaceOrder=-6:6;
[~,angle_loc]=ismember(View.SpaceOrder,FourierBgFRM.rad.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierBgFRM.rad.P.TimeOrder);
stem3(FourierBgFRM.rad.P.Amplitude(angle_loc,time_loc),'Color','#1976D2','LineStyle','none','LineWidth',2,'Marker','o','MarkerSize',5);
hold on
stem3(FourierBgFEM.rad.P.Amplitude(angle_loc,time_loc),'Color','#FF5722','LineStyle','-','LineWidth',2,'Marker','x');
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
   'xticklabel','ylim','ytick','yticklabel','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0.5 length(time_loc)+0.5],1:3:length(time_loc),0:3:12,...
    [0.5 length(angle_loc)+0.5],1:3:length(angle_loc),-18:9:18,[0,0.9],0:0.2:0.8};
set(ax,NameArrayAx,ValueArrayAx);
legend({'FRM','FEM'},'Position',[0.7,0.6,0.1,0.1])
view(-35,40);
%% ======================== FFT, tangential=================================
figure(4)
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
View.TimeOrder=0:12;
View.SpaceOrder=-6:6;
[~,angle_loc]=ismember(View.SpaceOrder,FourierBgFRM.tan.P.SpaceOrder);
[~,time_loc]=ismember(View.TimeOrder,FourierBgFRM.tan.P.TimeOrder);
stem3(FourierBgFRM.tan.P.Amplitude(angle_loc,time_loc),'Color','#1976D2','LineStyle','none','LineWidth',2,'Marker','o','MarkerSize',5);
hold on
stem3(FourierBgFEM.tan.P.Amplitude(angle_loc,time_loc),'Color','#FF5722','LineStyle','-','LineWidth',2,'Marker','x');
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
   'xticklabel','ylim','ytick','yticklabel','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0.5 length(time_loc)+0.5],1:3:length(time_loc),0:3:12,...
    [0.5 length(angle_loc)+0.5],1:3:length(angle_loc),-18:9:18,[0,0.04],0:0.01:0.4};
set(ax,NameArrayAx,ValueArrayAx);
legend({'FRM','FEM'},'Position',[0.7,0.6,0.1,0.1])
view(-35,40);