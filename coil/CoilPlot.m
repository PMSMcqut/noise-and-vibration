%% Coil Plot
function []=CoilPlot(Qs,Winding,m)
color=['r','y','b','m','g','c'];
% mark=['A','B','C','D','E','F'];
figure('Name','Coil Arrangement','NumberTitle','off')
for jj=1:2
    r=1;R=2.5*r*Qs/(2*pi)+2.5*r*(jj-1);
    for q=1:Qs
        angleS(q)=2*pi/(Qs)*(q-1);
        x(q)=R*cos(angleS(q)); y(q)=R*sin(angleS(q));
        angle_r=linspace(0,2*pi,360);
        x_r(q,:)=x(q)+r*cos(angle_r);
        y_r(q,:)=y(q)+r*sin(angle_r);
        plot(x_r(q,:),y_r(q,:),'-','LineWidth',1.3)
        hold on
        set(gcf,'color','w')
        ax=gca;
        ax.XAxis.Visible='off';
        ax.YAxis.Visible='off';
        axis equal
        for k=1:m
            switch Winding.all(jj,q)
                case k
                    fill([x_r(q,:)],[y_r(q,:)],color(k));
                    text(x(q)-0.05*abs(x(q)),y(q)-0*abs(y(q)),[char(65+(k-1)),'+'],'FontSize',8);
                case -k
                    fill([x_r(q,:)],[y_r(q,:)],color(k))
                    text(x(q)-0.05*abs(x(q)),y(q)-0*abs(y(q)),[char(65+(k-1)),'-'],'FontSize',8);
            end
        end
    end
end
alpha(0.5);
%% Winding layout
figure('Name','Winding Layout','NumberTitle','off')
for q=1:Qs
    line([q,q],[0,1],'LineWidth',1.3);
    hold on
    line([q+0.3,q+0.3],[0,1],'LineStyle','--','LineWidth',1.3);
    line([q,q+(6+0.3)/2],[1,1+0.5],'LineStyle','-','LineWidth',1.3);
    line([q,q+(6+0.3)/2],[0,-0.5],'LineStyle','-','LineWidth',1.3);
    line([q+0.3,q+0.3-(6+0.3)/2],[1,1+0.5],'LineStyle','-','LineWidth',1.3);
    line([q+0.3,q+0.3-(6+0.3)/2],[0,-0.5],'LineStyle','-','LineWidth',1.3);
    set(gca,'Xlim',[1-6-0.3 Qs+0.3+6],'Ylim',[-2 2],'DataAspectRatio', [1 0.4 1],'FontSize',10);
    text(q,0.5,num2str(q),'FontSize',10,'FontWeight','b');
    xticks([1:Qs]);
    set(gcf,'color','w')
    ax=gca;
    ax.YAxis.Visible='off';
    ax.XAxis.Visible='off';
end
end
