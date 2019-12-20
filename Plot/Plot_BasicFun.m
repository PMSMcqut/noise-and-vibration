function Plot_BasicFun(Basic_I,p,time_step,Basic_speed,custom_colormap,Barm_theta_rad,Barm_theta_tan,Bpm_theta_rad,Bpm_theta_tan)
Basic_T=1/(p*Basic_speed/60);
Basic_Time=(0:Basic_T/time_step:Basic_T-Basic_T/time_step)';
Basic_Theta_r=(0:360/time_step:360-360/time_step)';
%% Armture Flux
figure(1)
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ================= radial flux density ===========================
h=surf(Basic_I,Basic_Time*1000,Barm_theta_rad{1,1}');
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','Marker'};
VlaueArrayGcf={1,'interp','interp','-','none'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'ylim','ytick','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0,14],0:2:14,[0,20],0:4:20,[-0.1,0.1],-0.1:0.05:0.1};
set(ax,NameArrayAx,ValueArrayAx);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);

figure(2)
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ================= radial flux density ===========================
h=surf(Basic_I,Basic_Time*1000,Barm_theta_tan{1,1}');
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','Marker'};
VlaueArrayGcf={1,'interp','interp','-','none'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'ylim','ytick','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0,14],0:2:14,[0,20],0:4:20,[-0.1,0.1],-0.1:0.05:0.1};
set(ax,NameArrayAx,ValueArrayAx);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
%% PM Flux
figure(3)
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ================= radial flux density ===========================
h=surf(Basic_I,Basic_Time*1000,Bpm_theta_rad{1,1}');
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','Marker'};
VlaueArrayGcf={1,'interp','interp','-','none'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'ylim','ytick','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0,14],0:2:14,[0,20],0:4:20,[-0.4,0.4],-0.4:0.2:0.4};
set(ax,NameArrayAx,ValueArrayAx);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);

figure(4)
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,100,580,450],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ================= radial flux density ===========================
h=surf(Basic_I,Basic_Time*1000,Bpm_theta_tan{1,1}');
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','Marker'};
VlaueArrayGcf={1,'interp','interp','-','none'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ----- 坐标轴属性设置 --------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'ylim','ytick','zlim','ztick'};
ValueArrayAx={15,'bold','Arial',1,'on','back',[0,14],0:2:14,[0,20],0:4:20,[-0.2,0.2],-0.2:0.1:0.2};
set(ax,NameArrayAx,ValueArrayAx);
colormap(custom_colormap{2}(1:end,:));
view(-45,40);
end