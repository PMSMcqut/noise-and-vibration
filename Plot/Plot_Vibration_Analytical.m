function []=Plot_Vibration_Analytical(Ana)
% ----- ͼ���������� -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'spectrum of vibration','white',[500,100,600,600],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
%% deformation
% ----- ͼ����������--------------------------------------------------
subplot(3,1,1)
h=stem(Ana.def.freq(1:end),Ana.def.mag(1:end));
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'x','-','r';};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth'};
ValueArrayAx={11,'Times New Roman',1};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it f \rm(Hz)',13};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it Def \rm(m)',13};
set(ty,NameArrayTy,ValueArrayTy);
%% vecolity
% ----- ͼ����������--------------------------------------------------
subplot(3,1,2)
h=stem(Ana.v.freq,Ana.v.mag);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'x','-','r'};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth'};
ValueArrayAx={11,'Times New Roman',1};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it f \rm(Hz)',13};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it v \rm(m/s)',13};
set(ty,NameArrayTy,ValueArrayTy);
%% Acceleration
% ----- ͼ����������--------------------------------------------------
subplot(3,1,3)
h=stem(Ana.a.freq,Ana.a.mag);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'x','-','r'};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth'};
ValueArrayAx={11,'Times New Roman',1};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it f \rm(Hz)',13};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it a \rm(m/s^2)',13};
set(ty,NameArrayTy,ValueArrayTy);
end