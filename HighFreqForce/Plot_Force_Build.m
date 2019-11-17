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
ValueArrayFig={'r',1;'k',1};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','xtick','xticklabel'};
ValueArrayAx={13.5,'Times New Roman',1,[0.5 length(angle_loc)+0.5],1:1:length(angle_loc),-36:6:36};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it r',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it \sigma_r \rm(N/m^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'current 1000Hz force 950Hz','current 100Hz force 50Hz'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);

subplot(1,2,2)
h=bar([FourierFt_1000.P.Amplitude(angle_loc,20),FourierFt_100.P.Amplitude(angle_loc,2)]);% time order: f/f0+1
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',1;'k',1};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','xtick','xticklabel'};
ValueArrayAx={13.5,'Times New Roman',1,[0.5 length(angle_loc)+0.5],1:1:length(angle_loc),-36:6:36};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it r',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it \sigma_t \rm(N/m^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'current 1000Hz force 950Hz','current 100Hz force 50Hz'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
end