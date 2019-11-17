function []=Plot_Vibration_Validate(Ana,Test,Freq)
step=1;
[~,freq_loc_min]=ismember(min(Freq),Test.def.freq);
[~,freq_loc_max]=ismember(max(Freq),Test.def.freq);
% ----- ͼ���������� -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'spectrum of vibration','white',[500,100,600,600],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
%% deformation
% ----- ͼ����������--------------------------------------------------
subplot(3,1,1)
h1=stem(Ana.def.freq(1:end)',Ana.def.mag(1:end)');
hold on
h2=stem(Test.def.freq(freq_loc_min:step:freq_loc_max),Test.def.mag(freq_loc_min:step:freq_loc_max));
NameArrayFig={'LineWidth','Marker','MarkerSize','LineStyle','color'};
ValueArrayFig1={1.5,'x',6,'-','r'};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
ValueArrayFig2={1.5,'*',6,'--','b'};
set(h1,NameArrayFig,ValueArrayFig1)
set(h2,NameArrayFig,ValueArrayFig2)
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
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Analytic','Test'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
%% vecolity
% ----- ͼ����������--------------------------------------------------
subplot(3,1,2)
h1=stem(Ana.v.freq(1:end)',Ana.v.mag(1:end)');
hold on
h2=stem(Test.v.freq(freq_loc_min:step:freq_loc_max),Test.v.mag(freq_loc_min:step:freq_loc_max));
NameArrayFig={'LineWidth','Marker','MarkerSize','LineStyle','color'};
ValueArrayFig1={1.5,'x',6,'-','r'};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
ValueArrayFig2={1.5,'*',6,'--','b'};
set(h1,NameArrayFig,ValueArrayFig1)
set(h2,NameArrayFig,ValueArrayFig2)
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
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Analytic','Test'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
%% Acceleration
% ----- ͼ����������--------------------------------------------------
subplot(3,1,3)
h1=stem(Ana.a.freq(1:end)',Ana.a.mag(1:end)');
hold on
h2=stem(Test.a.freq(freq_loc_min:step:freq_loc_max),Test.a.mag(freq_loc_min:step:freq_loc_max));
NameArrayFig={'LineWidth','Marker','MarkerSize','LineStyle','color'};
ValueArrayFig1={1.5,'x',6,'-','r'};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
ValueArrayFig2={1.5,'*',6,'--','b'};
set(h1,NameArrayFig,ValueArrayFig1)
set(h2,NameArrayFig,ValueArrayFig2)
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
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'Analytic','Test'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);
end