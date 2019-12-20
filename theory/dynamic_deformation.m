clear;clc;
r=linspace(0,5,1000);
damp=[0.1 0.3 0.4 0.5 1.0 1.5 2.0 3.0];
for i=1:length(damp)
    M(:,i)=1./abs(sqrt((1-r.^2).^2+(2*damp(i)*r).^2));
    fai(:,i)=atan(2*damp(i)*r./(1-r.^2));
end
figure(1)
% subplot(1,2,1)
% plot(r,M)
% subplot(1,2,2)
% plot(r,fai)
plot(r,M,'LineWidth',1.5)
hold on
line([1,1],[0,5],'LineStyle','--','LineWidth',1.3);
line([0,5],[1,1],'LineStyle','--','LineWidth',1.3);
set(gcf,'color','white')
set(gca,'xlim',[0,5],'ylim',[0 5],'fontsize',12)
legend('\zeta=0.1','\zeta=0.3','\zeta=0.4','\zeta=0.5','\zeta=1.0','\zeta=1.5','\zeta=2.0','\zeta=3.0')
xlabel('频率比')
ylabel('放大系数')
