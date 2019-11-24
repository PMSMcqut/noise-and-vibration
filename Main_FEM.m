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
close all
%% Initialization
AddPath;
LoadData;
mm=1e-3;
mu0=4*pi*10^-7;% permeability in vacuum
Condition='load'
current='sin'
Flux_method='FEM' % FEM or FRM
Force_method='Integral'
FRF_method='equation'
% =================================================================
rpm=1000;% speed
f_min=100;f_max=4900;f_step=100;% The frequency range in the vibration calculation
Freq=f_min:f_step:f_max;
% =================================================================
%% Data Input
%======================= Geometry Data,Simulation Data =============
Qs=36;% slot number
p=3;% pole pairs
L=85*mm;% stack legnth
Ris=40.9*mm;% stator inner radius
SlotOpen=2.8*mm;% slot opening
alpha_b0=SlotOpen/Ris;% cofficient of slot opening
Nt=gcd(Qs,p);% number of motor units
%======================= Coil information ==========================
yq=6;m=6;
Ns=14;% number of turns in series
Nlayer=2; % number of layers
ap=1; % number of parallel path
Nc=Ns*Nlayer; % number of conductors
n3ph=2; % number of three phase winding
Beta=30*pi/180;% phase belt degree
alphaS=30*pi/180;% phase shift between the two sets of three phase winding
f0=p*rpm/60;% fundamental electrical frequncy
T=1/f0;% electrical period
Ipeak=7.07; % peak value of phase current
gamma=21;
time=0:T/200:T;
% ====================== Structure parameters ======================
Mode=[0,2,4,6];% number of model in calculation
ForceNum=[6,4,2,0,-2,-4,-6];% spatial order of force in calculation
f_modal=[9100,1867.25,6277.8,11254];% modal frequency[0,2,4,6]
damp=[5.63,1.16,3.88,6.96]*1e-02;% damping ratio
StaDef.rad=[1.4056e-9,4.2437e-8,2.3e-9,1.0034e-9]; %[0,2,4,6],Static Deformation Function,Unit:m
StaDef.tan=[6.6104e-11,3.96e-8,3.0225e-9,1.6588e-9]*(-1i);
StaDef.tq=[4.0914e-8,1.088e-6,1.3972e-7,8.8213e-8]*(1i);
% ======================= Flux and Force Select ===================
switch Condition
    case 'load'
        switch current
            case 'harm'
                Br=Bg_load_HF.rad;
                Bt=Bg_load_HF.tan;
                ForceJmag=ForceJmagLoadHF;
            case 'sin'
                Br=Bg_load.rad;
                Bt=Bg_load.tan;
                ForceJmag=ForceJmagLoad;
                
        end
        Test=TestLoad;
    case 'noload'
        Br=Bg_noload.rad;
        Bt=Bg_noload.tan;
        ForceJmag=ForceJmagNoload;
        Test=TestNoload;
end
% ====================== Calculation parameter =====================
TimeStep=size(Br,2)-1;
AngleStep=size(Br,1)-1;
Time=0:T/TimeStep:T;% Time for FFT
Space=0:360/AngleStep:360;
ToothAngle=0:360/Qs:360;
TimeDomain.Time=Time(1:TimeStep);
TimeDomain.Space=Space(1:AngleStep);% Space angle for FFT
TimeDomain.ToothAngle=ToothAngle(1:Qs);% Tooth angle for FFT
%% Force Calcualtion
[F,Frz,Ftz,Mrz,ForceIntegral,FourierBr,FourierBt,FourierFr,FourierFt,FourierRad,FourierTan,FourierTq,Force]...
    =Force_Calculation(Br,Bt,Freq,ForceNum,mu0,L,Ris,Qs,Time,Space,TimeStep,AngleStep,TimeDomain,f0,Force_method);
%% Frequency Response Function
FRF_freq=100:100:18000;
FRF_Order=[1 2 3 4];
damp=1/(2*pi)*(2.76*10^-5*FRF_freq+0.062)*10;
[FreqResEq,FreqResWave,FreqResTooth]=FreqResFun_Calculation(Mode,FRF_freq,FreqResWave,FreqResTooth,StaDef,f_modal,damp);
%% Vibration Calculation
switch FRF_method
    case 'equation'
        FRF.rad=FreqResEq.rad.complex(1:length(Freq),:)';
        FRF.tan=FreqResEq.tan.complex(1:length(Freq),:)';
        FRF.tq=FreqResEq.tq.complex(1:length(Freq),:)';
        [Ana]=Vibration_Calculation(Frz,Ftz,Mrz,Force,FRF,Mode,ForceNum,f_min,f_step,f_max,Freq,f0,TimeDomain,FRF_method);
    case 'Wave Excitation'
        FRF.rad=FreqResWave.rad.complex(1:length(Freq),:)';
        FRF.tan=FreqResWave.tan.complex(1:length(Freq),:)';
        FRF.tq=FreqResWave.tq.complex(1:length(Freq),:)';
        [Ana]=Vibration_Calculation(Frz,Ftz,Mrz,Force,FRF,Mode,ForceNum,f_min,f_step,f_max,Freq,f0,TimeDomain,FRF_method);
    case 'Tooth Excitation'
        FRF.rad=FreqResTooth.rad.complex(:,1:length(Freq));
        FRF.tan=FreqResTooth.tan.complex(:,1:length(Freq));
        FRF.tq=FreqResTooth.tq.complex(:,1:length(Freq));
        [Ana]=Vibration_Calculation(Frz,Ftz,Mrz,Force,FRF,Mode,ForceNum,f_min,f_step,f_max,Freq,f0,TimeDomain,FRF_method);
end
%% Post Process
% FigPlot
% figure(1)
% Plot_Flux_Density(Br,Bt,FourierBr,FourierBt,Time,Space);
% figure(2)
% Plot_Force_Density(F,FourierFr,FourierFt,Time,Space);
% figure(3)
% Plot_Harmonic_2D(Br,Bt,F,Time,TimeStep,Space,AngleStep,f0);
% figure(4)
% Plot_Pcolor_Force_Density(F,FourierFr,FourierFt,Time,Space);
% figure(5)
% Plot_Lumped_Force(Frz,Ftz,Mrz,Time,TimeStep,ToothAngle,Qs,FourierRad,FourierTan,FourierTq);
figure(6)
Plot_Force_Validate(ForceJmag,ForceIntegral,Time,TimeStep,ToothAngle,Qs,f0);
figure(7)
Plot_FRF_Analytical(Mode,FreqResEq,FRF_freq);
figure(8)
Plot_FRF_Validate(FRF_Order,FreqResEq,FreqResWave,FRF_freq);
% figure(9)
% Plot_Vibration_Analytical(Ana);
figure(10)
Plot_Vibration_Validate(Ana,Test);