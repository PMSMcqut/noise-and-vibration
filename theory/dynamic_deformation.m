clear;clc;
close all
r=linspace(0,5,1000);
damp=[0.05 0.1 0.15 0.2 0.25];
for i=1:length(damp)
    M(:,i)=1./abs(sqrt((1-r.^2).^2+(2*damp(i)*r).^2));
    fai(:,i)=atan(2*damp(i)*r./(1-r.^2));
end
figure(1)
fig=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'spectrum of vibration','white',[500,100,600,300],'centimeters'};
set(fig,NameArrayGcf,VlaueArrayGcf);
h1=plot(r,M,'LineWidth',2);
NameArrayFig={'LineStyle'};
ValueArrayFig={'-','--',':','-.','-'}';% ����������ͼ���е��м�����ͼ�Ķ�������������ÿ�������м�������
set(h1,NameArrayFig,ValueArrayFig)
hold on
line([1,1],[0,10],'LineStyle','--','LineWidth',1.5);
line([0,5],[1,1],'LineStyle','--','LineWidth',1.5);
% ----- �������������� ----------------------------------------------------
ax=gca;
NameArrayAx={'FontSize','FontName','LineWidth','xlim','xtick','xticklabel','ylim','ytick','yticklabel'};
ValueArrayAx={12,'FixedWidth',1,[0,5],0:0.5:5,0:0.5:5,[0,10],0:2:10,{'0','2\delta_s','4\delta_s','6\delta_s','8\delta_s','10\delta_s'}};
set(ax,NameArrayAx,ValueArrayAx);
% ----- �������ǩ���� ----------------------------------------------------
tx=xlabel('');
NameArrayTx={'String','FontSize'};
ValueArrayTx={'Ƶ�ʱ�',13};
set(tx,NameArrayTx,ValueArrayTx);
ty=ylabel('');
NameArrayTy={'String','FontSize'};
ValueArrayTy={'��ֵ',13};
set(ty,NameArrayTy,ValueArrayTy);
% ----- ͼ������ ---------------------------------------------------------
lgd=legend;
NameArrayLgd={'String','FontSize','Location'};
ValueArrayLgd={{'\xi_s=0.05','\xi_s=0.1','\xi_s=0.15','\xi_s=0.2','\xi_s=0.25'},12,'best'};
set(lgd,NameArrayLgd,ValueArrayLgd);

