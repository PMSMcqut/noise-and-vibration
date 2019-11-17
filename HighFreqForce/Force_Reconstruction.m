% Vibration Calculation Program
% Copyright (c) 2017-2020
% School of Electrical and Electronics of Engineering
% Huazhong University of Science and Technology
% All Rights Reserved
%
%              Programmer:Lu,Yang yanglu_hust@sina.com
%              Version:3.1
%              Last modified:6/12/2019
clear;clc;
%% Initialization
mm=1e-3;
mu0=4*pi*10^-7;% permeability in vacuum
%% Data Input
% ======================= Flux Imported ===================
load('E:\OneDrive - i.b.school.nz\Program\MATLAB\VibrationCalculation\Vibration\Data\Br_FR_100Hz.mat');
load('E:\OneDrive - i.b.school.nz\Program\MATLAB\VibrationCalculation\Vibration\Data\Bt_FR_100Hz.mat');
load('E:\OneDrive - i.b.school.nz\Program\MATLAB\VibrationCalculation\Vibration\Data\Br_FR_1000Hz.mat');
load('E:\OneDrive - i.b.school.nz\Program\MATLAB\VibrationCalculation\Vibration\Data\Bt_FR_1000Hz.mat');
%======================= Geometry Data,Simulation Data =============
L=85*mm;% stack legnth
Ris=40.9*mm;% stator inner radius
SlotOpen=2.8*mm;% slot opening
alpha_b0=SlotOpen/Ris;% cofficient of slot opening
p=3;
Qs=36;
Nt=gcd(Qs,p);% number of motor units
rpm=1000;% speed
f0=p*rpm/60;% fundamental electrical frequncy
T=1/f0;% electrical period
% ====================== Calculation parameter =====================
TimeStep=200;
AngleStep=360;
Time=0:T/TimeStep:T-T/TimeStep;% Time for FFT
Space=0:360/AngleStep:360-360/AngleStep;
ToothAngle=0:360/Qs:360-360/Qs;
TimeDomain.Time=Time(1:TimeStep);
TimeDomain.Space=Space(1:AngleStep);% Space angle for FFT
TimeDomain.ToothAngle=ToothAngle(1:Qs);% Tooth angle for FFT
f_min=100;f_max=4900;f_step=100;
Freq=f_min:f_step:f_max;
%% Force Calcualtion
[F_100,Frz_100,Ftz_100,Mrz_100,ForceIntegral_100,FourierBr_100,FourierBt_100,FourierFr_100,FourierFt_100,FourierRad_100,FourierTan_100,FourierTq_100]...
    =HighFreqForceRebulid(Br_FR_100Hz,Bt_FR_100Hz,mu0,L,Ris,Qs,Time,Space,TimeStep,AngleStep,TimeDomain,f0);
[F_1000,Frz_1000,Ftz_1000,Mrz_1000,ForceIntegral_1000,FourierBr_1000,FourierBt_1000,FourierFr_1000,FourierFt_1000,FourierRad_1000,FourierTan_1000,FourierTq_1000]...
    =HighFreqForceRebulid(Br_FR_1000Hz,Bt_FR_1000Hz,mu0,L,Ris,Qs,Time,Space,TimeStep,AngleStep,TimeDomain,f0);
%% Post Process
figure(1)
Plot_Pcolor_Force_Density(F_100,FourierFr_100,FourierFt_100,Time,Space);
figure(2)
Plot_Pcolor_Force_Density(F_1000,FourierFr_1000,FourierFt_1000,Time,Space);
figure(3)
[angle_loc]=Plot_Force_Build(FourierFr_100,FourierFt_100,FourierFr_1000,FourierFt_1000,Time,Space);