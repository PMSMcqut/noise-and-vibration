clear;clc;
load('FluxDensity.txt');
ang=FluxDensity(:,1);
Bpmr_FEA=FluxDensity(:,2);
Bpmr_Ana=FluxDensity(:,3);
Bpmt_FEA=FluxDensity(:,4);
Bpmt_Ana=FluxDensity(:,5);
Barmr_FEA=FluxDensity(:,6);
Barmr_Ana=FluxDensity(:,7);
Barmt_FEA=FluxDensity(:,8);
Barmt_Ana=FluxDensity(:,9);
Bgr_FEA=FluxDensity(:,10);
Bgr_Ana=FluxDensity(:,11);
Bgt_FEA=FluxDensity(:,12);
Bgt_Ana=FluxDensity(:,13);
figure;grid
set(0,'defaultfigurecolor','w')
s(1)=subplot(2,3,1);
plot(ang,Bpmr_FEA,'ob','MarkerSize',5,'MarkerFacecolor','b')
hold on
plot(ang,Bpmr_Ana,'r','LineWidth',1.5)
set(gca,'xlim',[0 360]);
title(s(1),'PM flux density(radial)')
xlabel('\theta (mech. degrees)')
ylabel('B_{pmr} (T)')
legend('FEA','Analytical');
s(2)=subplot(2,3,4);
plot(ang,Bpmt_FEA,'ob','MarkerSize',5,'MarkerFacecolor','b')
hold on
plot(ang,Bpmt_Ana,'r','LineWidth',1.5)
set(gca,'xlim',[0 360]);
title(s(2),'PM flux density(tangential)')
xlabel('\theta (mech. degrees)')
ylabel('B_{pmt} (T)')
legend('FEA','Analytical');
s(3)=subplot(2,3,2);
plot(ang,Barmr_FEA,'ob','MarkerSize',5,'MarkerFacecolor','b')
hold on
plot(ang,Barmr_Ana,'r','LineWidth',1.5)
set(gca,'xlim',[0 360]);
title(s(3),'Armature flux density(radial)')
xlabel('\theta (mech. degrees)')
ylabel('B_{armr} (T)')
legend('FEA','Analytical');
s(4)=subplot(2,3,5);
plot(ang,Barmt_FEA,'ob','MarkerSize',5,'MarkerFacecolor','b')
hold on
plot(ang,Barmt_Ana,'r','LineWidth',1.5)
set(gca,'xlim',[0 360]);
title(s(4),'Armature flux density(tangential)')
xlabel('\theta (mech. degrees)')
ylabel('B_{armt} (T)')
legend('FEA','Analytical');
s(5)=subplot(2,3,3);
plot(ang,Bgr_FEA,'ob','MarkerSize',5,'MarkerFacecolor','b')
hold on
plot(ang,Bgr_Ana,'r','LineWidth',1.5)
set(gca,'xlim',[0 360]);
title(s(5),'Air-gap flux density(radial)')
xlabel('\theta (mech. degrees)')
ylabel('B_{gr} (T)')
legend('FEA','Analytical');
s(6)=subplot(2,3,6);
plot(ang,Bgt_FEA,'ob','MarkerSize',5,'MarkerFacecolor','b')
hold on
plot(ang,Bgt_Ana,'r','LineWidth',1.5)
set(gca,'xlim',[0 360]);
title(s(6),'Air-gap flux density(tangential)')
xlabel('\theta (mech. degrees)')
ylabel('B_{gt} (T)')
legend('FEA','Analytical');