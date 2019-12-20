% Waterfall and colormap plot with different speed and frequency for vibration
% Copyright (c) 2017-2020
% School of Electrical and Electronics Engineering
% Huazhong University of Science and Technology
% All Rights Reserved
% 
%              Programmer:Lu,Yang yanglu_hust@sina.com 
%              Version:2.0
%              Last modified:11/28/2018
clear;clc;
close all
load('custom_colormap.mat');
load('TestLoad.mat');
speed_min=300;
speed_max=1500;
speed_step=50;
fig.speed=speed_min:speed_step:speed_max;
%% Plot Test
% -------- AutoPower Linear Unit: m/s^2----------------------------------
APL=TestLoad.a;
% -------- Unit: g -----------------------------------------
APL_g=APL/9.8;
% -------- Format: dB -----------------------------
APL_dB=20*log(APL/(10^-6));
fig.mag=APL;
fig.freq=TestLoad.freq;
%% Plot Synthesis
% fig.freq=0:5:20000;
% for i=1:length(fig.speed)
%     mag_temp=zeros(length(fig.freq),1);
%     [~,freq_loc]=ismember(Vib_map{i}.freq,fig.freq);
%     mag_temp(freq_loc,:)=Vib_map{i}.mag;
%     fig.mag(:,i)=mag_temp;
% end
%% Figure plot
fig.rpm.min=speed_min;
fig.rpm.max=speed_max;
fig.rpm.step=100;
fig.f.min=0;
fig.f.max=18000;
fig.f.step=2000;
% ----------------waterfall plot-------------------------------
figure(1)
z_max=1;
fig.zlabel='Acceleration (m/s^2)';
WaterfallPlot(fig,z_max)
% ----------------colormap plot---------------------------
figure(2)
c_Label='Acceleration (m/s^2)';
caxis_max=2;
[fig]=ColormapPlot(fig,custom_colormap{1},c_Label,caxis_max);