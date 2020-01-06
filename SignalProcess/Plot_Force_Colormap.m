clear;clc;
close all
load('custom_colormap.mat');
load('Force_map.mat');
load('Force_wave.mat');
ForceOrder=[6,4,2,0,-2,-4,-6];
ForceNum=-4;
[~,force_loc]=ismember(ForceNum,ForceOrder);
speed_min=300;speed_max=1500;speed_step=100;
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
fig.f.max=3000;
fig.f.step=500;
%% Figure plot
% ----------------waterfall plot-------------------------------
% figure(1)
% z_max=5;
% fig.zlabel='Force (N)';
% WaterfallPlot(fig,z_max)
% ----------------colormap plot---------------------------
figure(2)
c_Label='Force (N)';
caxis_max=0.1;
[fig]=ColormapPlot(fig,custom_colormap{1},c_Label,caxis_max);