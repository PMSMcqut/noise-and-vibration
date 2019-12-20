function [fig]=Plot_Force_Colormap(ForceNum,speed_min,speed_max,speed_step,Force_map,custom_colormap)
ForceOrder=[6,4,2,0,-2,-4,-6];
[~,force_loc]=ismember(ForceNum,ForceOrder);
fig.speed=speed_min:speed_step:speed_max;
fig.freq=0:5:20000;
for i=1:length(fig.speed)
    mag_temp=zeros(length(fig.freq),1);
    [~,freq_loc]=ismember(Force_map{i}.freq,fig.freq);
    mag_temp(freq_loc,:)=abs(Force_map{i}.rad(force_loc,:)');
    fig.mag(:,i)=mag_temp;
end
fig.rpm.min=speed_min;
fig.rpm.max=speed_max;
fig.rpm.step=speed_step;
fig.f.min=0;
fig.f.max=18000;
fig.f.step=2000;
%% Figure plot
% ----------------colormap plot---------------------------
c_Label='Force (N)';
caxis_max=2;
[fig]=ColormapPlot(fig,custom_colormap{1},c_Label,caxis_max);