%% waterfall plot
function []=WaterfallPlot(fig,z_max)
figure=gcf;
NameArrayGcf={'Name','color','position','Units'};
VlaueArrayGcf={'','white',[500,300,700,300],'centimeters'};
set(figure,NameArrayGcf,VlaueArrayGcf);
colormap hsv;
waterfall(fig.freq,fig.speed,fig.mag');
ylabel('Speed (r/min)','Rotation',90);
xlabel('Frequency (kHz)','Rotation',0);
% zlabel(fig.zlabel);
set(gca,'xlim',[fig.f.min,fig.f.max],'xtick',fig.f.min:fig.f.step*2:fig.f.max,'xticklabel',(fig.f.min:fig.f.step*2:fig.f.max)/1000);
set(gca,'ylim',[fig.rpm.min,fig.rpm.max],'ytick',fig.rpm.min:fig.rpm.step*3:fig.rpm.max,'yticklabel',fig.rpm.min:fig.rpm.step*3:fig.rpm.max);
set(gca,'zlim',[0 z_max]);
set(gca,'fontsize',13.5,'FontName','Arial','LineWidth',1.2);
grid off
box on
view(-0.01,60);
end