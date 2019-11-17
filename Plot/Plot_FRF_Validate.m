function []=Plot_FRF_Validate(FRF_Order,FreqResEq,FreqResFEA,FRF_freq)
% ----- 图窗属性设置 -----------------------------------------------
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'Frequency Response Function Validation','white',[500,100,800,800],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
% ----- 图形属性设置--------------------------------------------------
subplot(3,1,1)
plot(FRF_freq,FreqResFEA.rad.amp(:,FRF_Order),'LineStyle','--','Marker','x','LineWidth',1.5)
hold on
plot(FRF_freq,FreqResEq.rad.amp(:,FRF_Order),'LineStyle','-','Marker','none','LineWidth',1.5)
title('Radial Frequency Response Function')
xlabel('\it f \rm(Hz)')
ylabel('\it Mag \rm(m/N)')
set(gca,'FontSize',11,'FontName','Times New Roman')
legend({'v=0-FEA','v=2-FEA','v=4-FEA','v=6-FEA','v=0-Analytical','v=2-Analytical','v=4-Analytical','v=6-Analytical'},'Location','best','NumColumns',2)
% legend({'FEA','Analytical'},'Location','best')
subplot(3,1,2)
plot(FRF_freq,FreqResFEA.tan.amp(:,FRF_Order),'LineStyle','--','Marker','x','LineWidth',1.5)
hold on
plot(FRF_freq,FreqResEq.tan.amp(:,FRF_Order),'LineStyle','-','Marker','none','LineWidth',1.5)
title('Tangential Frequency Response Function')
xlabel('\it f \rm(Hz)')
ylabel('\it Mag \rm(m/N)')
set(gca,'FontSize',11,'FontName','Times New Roman')
legend({'v=0-FEA','v=2-FEA','v=4-FEA','v=6-FEA','v=0-Analytical','v=2-Analytical','v=4-Analytical','v=6-Analytical'},'Location','best','NumColumns',2)
% legend({'FEA','Analytical'},'Location','best')
subplot(3,1,3)
plot(FRF_freq,FreqResFEA.tq.amp(:,FRF_Order),'LineStyle','--','Marker','x','LineWidth',1.5)
hold on
plot(FRF_freq,FreqResEq.tq.amp(:,FRF_Order),'LineStyle','-','Marker','none','LineWidth',1.5)
title('Torque Frequency Response Function')
xlabel('\it f \rm(Hz)')
ylabel('\it Mag \rm(m/Nm)')
set(gca,'FontSize',11,'FontName','Times New Roman')
legend({'v=0-FEA','v=2-FEA','v=4-FEA','v=6-FEA','v=0-Analytical','v=2-Analytical','v=4-Analytical','v=6-Analytical'},'Location','best','NumColumns',2)
% legend({'FEA','Analytical'},'Location','best')
end

        
