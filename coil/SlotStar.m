%% calculation slot star
function []=SlotStar(Qs,p,m,Winding,Beta)
figure('Name','Slot Star','NumberTitle','off');
alpha_e = 360*p/Qs *pi/180;% 槽距电角
Qsn = Qs/gcd(Qs,p);% 单元电机槽数
if Qsn == p
    Qsn = 2*Qsn
end
c = complex(cos((1:Qsn)*alpha_e),sin((1:Qsn)*alpha_e))';
Amp=abs(c);
R=ceil(max(Amp));
arrow3(zeros(length(c),2),[real(c),imag(c)],'-k2',0.8,1.4,1,0.8,1)
for ii = 1 : Qsn
    text(1.1*cos((ii-1)*alpha_e),1.1*sin((ii-1)*alpha_e),num2str(ii),'FontSize',12);
end
set(gcf,'color','w')
ax=gca;
ax.XAxis.Visible='off';
ax.YAxis.Visible='off';
hold on
axis([-1 1 -1 1]);
BetaNum=2*pi/Beta;
color=['r','y','b','m','g','c'];
for jj=1:BetaNum/m
    for i=1:m
        angle1=-2*pi/Qsn/2+(i-1)*Beta+pi*(jj-1);
        angle2=-2*pi/Qsn/2+i*Beta+pi*(jj-1);
        theta=linspace(angle1,angle2,360);
        x=R*cos(theta); y=R*sin(theta);
        plot(x,y,'-','LineWidth',1.3)
        hold on; axis equal
        fill([0,x],[0,y],color(i))
    end
end
alpha(0.5);
end