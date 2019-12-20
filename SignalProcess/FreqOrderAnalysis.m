p=3;
f1=p*fig.speed'/60;
fc=8000;
OrderFreq=round([2*f1,6*f1, fc-5*f1,fc-3*f1,fc+3*f1,fc+5*f1,2*fc-4*f1,2*fc-2*f1,2*fc-0*f1,2*fc+2*f1,2*fc+4*f1]);
for i=1:1:length(fig.speed)
    for j=1:1:size(OrderFreq,2)
        if ~isempty(find(fig.freq==OrderFreq(i,j),1))
            loc=find(fig.freq==OrderFreq(i,j));
            FreqOrder(i,j)=fig.mag(loc,i);
        else
            loc1=find(fig.freq==OrderFreq(i,j)-1);
            loc2=find(fig.freq==OrderFreq(i,j)+1);
            FreqOrder(i,j)=(fig.mag(loc1,i)+fig.mag(loc2,i))/2;
        end
    end
end
%% Figure Plot
fig1=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'Order Analysis','white',[500,100,600,350],'centimeters'};
set(fig1,NameArrayGcf,VlaueArrayGcf);
% ------ Fourier Transfer -----------------------------------------------
% ----- 图形属性设置--------------------------------------------------
h=plot(fig.speed,FreqOrder);
set(h,'LineWidth',1.5);
% % ----- 坐标轴属性设置 ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','DataAspectRatio','xlim','xtick','xticklabel','ylim'};
ValueArrayAx={13.5,'Arial',1,[400 2 1],[speed_min,speed_max],speed_min:6*speed_step:speed_max,speed_min:6*speed_step:speed_max,[0,3]};
set(ax,NameArrayAx,ValueArrayAx);
% % ----- 坐标轴标签设置 ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'Speed (r/min)',14};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'Acceleration (m/s^2)',14};
set(ty,NameArrayTy,ValueArrayTy);
% ----- 图例设置 ---------------------------------------------------------
% lgd=legend;
% NameArrayLgd={'String','FontSize','Location','NumColumns'};
% ValueArrayLgd={{'A','B','C','D','E','F'},10,'north',6};
% set(lgd,NameArrayLgd,ValueArrayLgd);