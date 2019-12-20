%% flux density
function []=Plot_Flux_Validate(Bg,Bg_load,AngleStep,f0,Space)
[FourierB_rad]=FFT_fun([Bg.rad(1,1:AngleStep)',Bg_load.rad(1:AngleStep,1)],Space(1:AngleStep),1,f0,1,'1D','fun');
[FourierB_tan]=FFT_fun([Bg.tan(1,1:AngleStep)',Bg_load.tan(1:AngleStep,1)],Space(1:AngleStep),1,f0,1,'1D','fun');
% ----- ͼ���������� -----------------------------------------------
fig=gcf;
NameArrayGcf={'color','position','Units'};
VlaueArrayGcf={'white',[500,100,800,400],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ----- ͼ����������--------------------------------------------------
subplot(2,2,1)
plot(Space(1:AngleStep)',Bg.rad(100,1:AngleStep)','LineStyle','-','Marker','none','LineWidth',1.5,'color','r');
hold on
plot(Space(1:AngleStep)',Bg_load.rad(1:AngleStep,100),'LineStyle','-','Marker','none','LineWidth',1.5,'color','k');
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','ylim'};
ValueArrayAx={12,'Times New Roman',1,[0 360],[-1.5,1.5]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
xlabel('\it \theta \rm(\circ)')
ylabel('\it B \rm(T)')
set(gca,'FontSize',12,'FontName','Times New Roman')
legend({'\it FRM','\it FEM'},'Location','best','NumColumns',2)

subplot(2,2,2)
plot(Space(1:AngleStep)',Bg.tan(1,1:AngleStep)','LineStyle','-','Marker','none','LineWidth',1.5,'color','r');
hold on
plot(Space(1:AngleStep)',Bg_load.tan(1:AngleStep,1),'LineStyle','-','Marker','none','LineWidth',1.5,'color','k');
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','ylim'};
ValueArrayAx={12,'Times New Roman',1,[0 360],[-0.6,0.6]};
set(ax,NameArrayAx,ValueArrayAx);
% title('Flux density comparision of FRM and FEM')
xlabel('\it \theta \rm(\circ)')
ylabel('\it B \rm(T)')
set(gca,'FontSize',12,'FontName','Times New Roman')
legend({'\it FRM','\it FEM'},'Location','best','NumColumns',2)

% =============== harmonic analysis ================================
subplot(2,2,3)
h=bar(FourierB_rad.P.Order(1:26)',FourierB_rad.P.Amplitude(1:26,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',0.8;'k',0.8};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={12,'Times New Roman',1,[0,1]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
xlabel('\it Order')
ylabel('\it  F \rm(N/m^2)')
set(gca,'FontSize',12,'FontName','Times New Roman')
legend({'\it FRM','\it FEM'},'Location','best','NumColumns',2)

subplot(2,2,4)
h=bar(FourierB_tan.P.Order(1:26)',FourierB_tan.P.Amplitude(1:26,:));
NameArrayFig={'FaceColor','BarWidth'};
ValueArrayFig={'r',0.8;'k',0.8};% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h,NameArrayFig,ValueArrayFig)
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','ylim'};
ValueArrayAx={12,'Times New Roman',1,[0,0.1]};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
xlabel('\it Order')
ylabel('\it  F \rm(N/m^2)')
set(gca,'FontSize',12,'FontName','Times New Roman')
legend({'\it FRM','\it FEM'},'Location','best','NumColumns',2)