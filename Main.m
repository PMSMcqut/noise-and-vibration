% Vibration Calculation Program
% Copyright (c) 2017-2020
% School of Electrical and Electronics of Engineering
% Huazhong University of Science and Technology
% All Rights Reserved
%
%              Programmer:Lu,Yang yanglu_hust@sina.com
%              Version:3.1
%              Last modified:6/12/2019
close all
clear;clc;
%% Initialization
AddPath;
LoadData;
Condition='load'
current='harm'
Flux_method='FRM' % FEM or FRM
Force_method='Integral'
FRF_method='equation'
% =================================================================
rpm=1000;% speed
f0=p*rpm/60;% fundamental electrical frequncy
T=1/f0;% electrical period
Ipeak=7.07; % peak value of phase current
gamma=21;
time=0:T/800:T;
f_min=100;f_max=18000;f_step=100;% The frequency range in the vibration calculation
Freq=f_min:f_step:(f_max);
% f_min=100;f_max=1/(time(2)-time(1))*0.5;f_step=100;% The frequency range in the vibration calculation
% Freq=f_min:f_step:(f_max-f_step);
% ======================= Flux and Force Select ===================
switch Condition
    case 'load'
        switch current
            case 'harm'
                switch Flux_method
                    case 'FRM'
                        [Winding,Slot]=WindingArrange(Qs,p,yq,m,n3ph,Beta,alphaS);
                        [SlotMatrix]=SlotMatrix(Qs,m,Winding);
                        [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time,gamma,'harm',I_harm,SlotMatrix,ap);
                        [Barm,Bpm,Bg]=FluxCal(time,Barm_fun,Bpm_fun,Islot);
                        Br=Bg.rad';
                        Bt=Bg.tan';
                        ForceJmag=ForceJmagLoadHF;
                    case 'FEM'
                        Br=Bg_load_HF.rad;
                        Bt=Bg_load_HF.tan;
                        ForceJmag=ForceJmagLoadHF;
                end
            case 'sin'
                switch Flux_method
                    case 'FRM'
                        [Winding,Slot]=WindingArrange(Qs,p,yq,m,n3ph,Beta,alphaS);
                        [SlotMatrix]=SlotMatrix(Qs,m,Winding);
                        [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time,gamma,'sin',I_harm,SlotMatrix,ap);
                        [Barm,Bpm,Bg]=FluxCal(time,Barm_fun,Bpm_fun,Islot);
                        Br=Bg.rad';
                        Bt=Bg.tan';
                        ForceJmag=ForceJmagLoad;
                    case 'FEM'
                        Br=Bg_load.rad;
                        Bt=Bg_load.tan;
                        ForceJmag=ForceJmagLoad;
                end
        end
        Test=TestLoad;
    case 'noload'
        switch Flux_method
            case 'FRM'
                [Winding,Slot]=WindingArrange(Qs,p,yq,m,n3ph,Beta,alphaS);
                [SlotMatrix]=SlotMatrix(Qs,m,Winding);
                [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time,gamma,'harm',I_harm,SlotMatrix,ap);
                [Barm,Bpm,Bg]=FluxCal(time,Barm_fun,Bpm_fun,Islot);
                Br=Bom.rad';
                Bt=Bpm.tan';
            case 'FEM'
                Br=Bg_noload.rad;
                Bt=Bg_noload.tan;
                ForceJmag=ForceJmagNoload;
        end
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
figure(1)
Plot_Flux_Density(Br,Bt,FourierBr,FourierBt,Time,Space); 
figure(2)
Plot_Force_Density(F,FourierFr,FourierFt,Time,Space);
figure(3)
Plot_Harmonic_2D(Br,Bt,F,Time,TimeStep,Space,AngleStep,f0);
figure(4)
Plot_Pcolor_Force_Density(F,FourierFr,FourierFt,Time,Space);
figure(5)
Plot_Lumped_Force(Frz,Ftz,Mrz,Time,TimeStep,ToothAngle,Qs,FourierRad,FourierTan,FourierTq);
figure(6)
Plot_Force_Validate(ForceJmag,ForceIntegral,Time,TimeStep,ToothAngle,Qs,f0);
figure(7)
Plot_FRF_Analytical(Mode,FreqResEq,FRF_freq);
figure(8)
Plot_FRF_Validate(FRF_Order,FreqResEq,FreqResWave,FRF_freq);
figure(9)
Plot_Vibration_Analytical(Ana);
figure(10)
Plot_Vibration_Validate(Ana,Test,Freq);
figure(11)
Plot_Flux_Validate(Bg,Bg_load,AngleStep,f0,Space);