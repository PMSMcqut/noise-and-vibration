%% Plot MMF, harmonic and Winding Factor
function []=FigPlot(Qs,m,theta,MMF,harm,MMF_pu,kwv,p)
xmax = length(harm);
figure('Name','MMF & Winding Factor','NumberTitle','off');
scrsz = get(0,'ScreenSize');
set(gcf,'Position',[10 100 scrsz(3)/3 scrsz(4)/2],'Color',[1 1 1],'PaperPositionMode','auto')
clf;
PoS=[0.1 0.68 0.88 0.26;0.1 0.38 0.88 0.26;0.10 0.08 0.88 0.26;]; % x, y, width, height
subplot(3,1,1);% plot MMF waveform
plot(theta,MMF,'r-','LineWidth',4);
hold on;
title(['Magneto-Motive Force of ',num2str(m),' phase ',num2str(Qs),'/',num2str(2*p),' Double-Layer'],'Fontsize',12);
ylabel('MMF')
xlabel('Position (melectrical degree)');
set(gca,'XTick',0:max(theta)/12:max(theta));
set(gca,'XTickLabel',{'0';'pi/6';'pi/3';'pi/2';'2pi/3';'5pi/6';'pi';'7pi/6';'4pi/3';'3pi/2';'5pi/3';'11pi/6';'2pi'});
set(gca,'Xlim',[0 max(theta)]);
set(gca,'Box','on');
grid on;
subplot(3,1,2);% plot MMF harmonic
bar(MMF_pu(2:length(harm)),'FaceColor','m','BarWidth',0.5);
hold on;
title('MMF harmonics','Fontsize',12);
ylabel('Amplitude')
xlabel('Harmonic order');
set(gca,'Xlim',[0 xmax]);
set(gca,'XTick',1:1:xmax,'XTickLabel',1:1:xmax);
set(gca,'Ylim',[0 1]);
set(gca,'YTick',0:0.2:1);
%% Calculation of THD
for tii=1:1000
    TH(tii)=MMF_pu(tii)^2;
end
THD = sqrt((sum(TH)-TH(2*p/2+1))/TH(2*p/2+1));
text(20,MMF_pu(2*p/2+1)*1.1,['THD=',num2str(THD)],'FontSize',12,'FontWeight','bold','Color','b');

subplot(3,1,3);% plot winding factor
bar(abs(kwv(1:xmax)),'FaceColor','m','BarWidth',0.5);
hold on;
title('Winding factor','Fontsize',12);
ylabel('Winding factor')
xlabel('Harmonic order');
set(gca,'Xlim',[0 xmax]);
set(gca,'Ylim',[0 1]);
text(p+0.4,kwv(p),['\leftarrow' num2str(kwv(p))], 'FontSize',12,'FontWeight','bold','Color','r');