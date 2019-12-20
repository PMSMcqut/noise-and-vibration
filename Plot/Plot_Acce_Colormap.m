function [fig]=Plot_Acce_Colormap(speed_min,speed_max,speed_step,Vib_map,custom_colormap)
fig.speed=speed_min:speed_step:speed_max;
fig.freq=0:5:20000;
for i=1:length(fig.speed)
    mag_temp=zeros(length(fig.freq),1);
    [~,freq_loc]=ismember(Vib_map{i}.freq,fig.freq);
    mag_temp(freq_loc,:)=Vib_map{i}.mag;
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
c_Label='Acceleration (m/s^2)';
caxis_max=2;
[fig]=ColormapPlot(fig,custom_colormap{1},c_Label,caxis_max);
end