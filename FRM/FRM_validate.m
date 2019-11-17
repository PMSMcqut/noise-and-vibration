%% FRM vs FEM
clear;clc;
load('Bt_FR_1000Hz.mat');
load('Bt_FEM_1000Hz.mat');
% ----- ͼ���������� -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'Integral force validation','white',[500,100,600,600],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ----- ͼ����������--------------------------------------------------
subplot(3,1,1)
h=plot((0:360),[Bt_FR_1000Hz(:,1),Bt_FEM_1000Hz(:,1)]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-','b';
    1.5,'none','-.','r'};
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim'};
ValueArrayAx={13.5,'Times New Roman',1,[0 360]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Time \rm(s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it B_r \rm(T)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'FRM','FEM'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
title('\it t_1')


% % ----- ͼ����������--------------------------------------------------
subplot(3,1,2)
h=plot((0:360),[Bt_FR_1000Hz(:,30),Bt_FEM_1000Hz(:,30)]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-','b';
    1.5,'none','-.','r'};
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim'};
ValueArrayAx={13.5,'Times New Roman',1,[0 360]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Time \rm(s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it B_r \rm(T)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'FRM','FEM'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
title('\it t_2')
% 
% % ----- ͼ����������--------------------------------------------------
subplot(3,1,3)
h=plot((0:360),[Bt_FR_1000Hz(:,70),Bt_FEM_1000Hz(:,70)]);
NameArrayFig={'LineWidth','Marker','LineStyle','color'};
ValueArrayFig={1.5,'none','-','b';
    1.5,'none','-.','r'};
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim'};
ValueArrayAx={13.5,'Times New Roman',1,[0 360]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'\it Time \rm(s)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'\it B_r \rm(T)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'FRM','FEM'},10,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
title('\it t_3')