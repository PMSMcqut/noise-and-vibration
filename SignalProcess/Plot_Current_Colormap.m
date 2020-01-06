% Waterfall and colormap plot with different speed and frequency for current
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
load('TestCurrent.mat');
%% data input
rpm_min=300;
rpm_max=1500;
rpm_step=100;
freq_max=18000;

fig.rpm.min=rpm_min;
fig.rpm.max=rpm_max;
fig.rpm.step=rpm_step;
fig.f.min=0;
fig.f.max=18000;
fig.f.step=2000;
fig.speed=rpm_min:rpm_step:rpm_max;
%% ��֪�������Σ�����FFT,�ٻ����ٲ�ͼ
p=3;
filename='noload';
newpath='E:\Project\PM-SynRM-vibration\PM-SynRM-multiphase\ʵ��\data\6phase-fullpitch\current\';
for rpm=rpm_min:rpm_step:rpm_max
    ii=1+(rpm-rpm_min)/rpm_step;
    eval(['load(''',newpath,filename,num2str(rpm),'rpm.mat'')']);
    % ����������ݽṹ��
    FFT_signal=struct('time',[],'blockName',[filename,'_',num2str(rpm),'rpm']);
    FFT_signal.signals=struct('values',[],'dimensions',1,'label','','title','','plotStyle',[1,1]);
    FFT_signal.time = (0:1e-6:(length(CH1)-1)*1e-06)'; %�ɲ����ʺ���ʱ�䳤�Ⱦ���
    FFT_signal.signals.values(:,1) =CH1(:,1); % 1 ��ʾ��һ��
    FFT_signal_temp{ii}=FFT_signal;
    FFTDATA=power_fftscope(FFT_signal_temp{ii});
    % -----------FFT analysis using Power GUI--------------------------
    FFTDATA.fundamental=p*rpm/60;
    FFTDATA.startTime=3;
    FFTDATA.cycles=rpm/rpm_step;
    FFTDATA.maxFrequency=freq_max;
    fft{ii}=power_fftscope(FFTDATA);
    % -----------remat the data (�����ݳ��Ȳ�һ��ʱͨ����ֵ�������ݣ������ݳ���һ��ʱ����Ҫ)----------
    fig.mag(:,ii)=interp1(fft{ii}.freq,fft{ii}.mag,fft{ii}.freq);
end
fig.freq=fft{1}.freq;
%% Figure input data�����е���Ƶ��ֱ�ӻ����ٲ�ͼ
% fig.mag=TestCurrent.mag;
% fig.freq=TestCurrent.freq;
%% Figure plot
% ----------------waterfall plot-------------------------------
figure(1)
z_max=0.3;
fig.zlabel='Current (A)';
WaterfallPlot(fig,z_max)
% ----------------colormap plot---------------------------------
figure(2)
c_Label='Current (A)';
caxis_max=0.05;
[fig]=ColormapPlot(fig,custom_colormap{1},c_Label,caxis_max);