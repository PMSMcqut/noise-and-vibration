function []=Plot_Vibration_Validate(Vib_map,Test,f_min,f_max,Plot_speed,speed)
step=1;
[~,freq_loc_min]=ismember(min(f_min),Test.freq);
[~,freq_loc_max]=ismember(max(f_max),Test.freq);
[~,syn_loc]=ismember(Plot_speed,speed);
[~,test_loc]=ismember(Plot_speed,(300:50:1500));
% ----- ͼ���������� -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'spectrum of vibration','white',[500,100,600,200],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
%% Acceleration
% ----- ͼ����������--------------------------------------------------
h1=stem(Vib_map{syn_loc}.freq(1:end)',Vib_map{syn_loc}.mag(1:end)');
hold on
h2=stem(Test.freq(freq_loc_min:step:freq_loc_max),Test.a(freq_loc_min:step:freq_loc_max,test_loc));
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