function [fig]=ColormapPlot(fig,custom_colormap,c_Label,caxis_max)

% ================ Interp data ==================================
[fig.F,fig.N]=ndgrid(fig.freq,fig.speed);
fig.speed_interp=fig.rpm.min:fig.rpm.step/(fig.rpm.step):fig.rpm.max;
fig.freq_interp=min(fig.freq):2:max(fig.freq);
[fig.F_interp,fig.N_interp]=ndgrid(fig.freq_interp,fig.speed_interp);
F=griddedInterpolant(fig.F,fig.N,abs(fig.mag),'linear');
fig.mag_interp=F(fig.F_interp,fig.N_interp);
% ================ Figure Plot ==================================
% ----- 图窗属性设置 -----------------------------------------------
figure=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,300,800,380],'centimeters'};
set(figure,NameArrayGcf,VlaueArrayGcf);
%%
h=surf(fig.F_interp,fig.N_interp,fig.mag_interp);
% ---------------- 图形属性 --------------------------------------
NameArrayGcf={'FaceAlpha','FaceColor','EdgeColor','LineStyle','LineWidth','Marker','MarkerSize','AlignVertexCenters'};
VlaueArrayGcf={1,'interp','interp','-',1.2,'none',4,'on'};
set(h,NameArrayGcf,VlaueArrayGcf);
% ---------------- 坐标轴属性 ------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontWeight','FontName','LineWidth','Box','BoxStyle','xlim','xtick'...
    ,'xticklabel','ylim','ytick','yticklabel','DataAspectRatio'};
ValueArrayAx={13.5,'bold','Arial',1,'off','full',[fig.f.min,fig.f.max],fig.f.min:fig.f.step:fig.f.max,...
    (fig.f.min:fig.f.step:fig.f.max)/1000,[fig.rpm.min,fig.rpm.max],fig.rpm.min:fig.rpm.step*3:fig.rpm.max,fig.rpm.min:fig.rpm.step*3:fig.rpm.max,[1 1 1]};
set(ax,NameArrayAx,ValueArrayAx);
% ---------------- 坐标轴标签设置
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'Frequency (kHz)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'Speed (r/min)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ---------------- ColorBar 属性 ---------------------------------
colormap(custom_colormap(1:end,:));
c=colorbar;
c.Label.String=c_Label;
c.Label.FontSize=13.5;
caxis([0 caxis_max]);%调整colorbar的颜色范围
% ---------------- View position ---------------------------------
view(2);
%----------------- Plot Box --------------------------------------
line([fig.f.min fig.f.max],[fig.rpm.min fig.rpm.min],'LineWidth',1.5,'LineStyle','-','Color','k')
line([fig.f.min fig.f.max],[fig.rpm.max fig.rpm.max],'LineWidth',1.5,'LineStyle','--','Color','k')
line([fig.f.min fig.f.min],[fig.rpm.min fig.rpm.max],'LineWidth',1.5,'LineStyle','-','Color','k')
line([fig.f.max fig.f.max],[fig.rpm.min fig.rpm.max],'LineWidth',1.5,'LineStyle','--','Color','k')
end