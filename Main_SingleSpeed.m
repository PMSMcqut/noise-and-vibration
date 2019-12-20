% Vibration Calculation Program
% Copyright (c) 2017-2020
% School of Electrical and Electronics of Engineering
% Huazhong University of Science and Technology
% All Rights Reserved
%
%              Programmer:Lu,Yang yanglu_hust@sina.com
%              Version:3.1
%              Last modified:6/12/2019
%% Display
Condition='load'
current='harm'
Flux_method='FRM' % FEM or FRM
Force_method='Integral'
FRF_method='equation' % equation, Wave Excitation, Tooth Excitation
% =================================================================
speed=1000;% speed
f0=p*speed/60;% fundamental electrical frequncy
T=1/f0;% electrical period
Ipeak=8; % peak value of phase current
gamma=21;
f_min=0;f_max=20000;f_step=f0;% The frequency range in the vibration calculation
Freq=f_min:f_step:f_max-f_step;
step=2*round(T*f_max);%(Fmax:banwidth)
time=0:T/step:T;
% ======================= Flux and Force Select ===================
switch Condition
    case 'load'
        switch current
            case 'harm'
                switch Flux_method
                    case 'FRM'
                        [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time(1:end),gamma,'harm',I_harm{8},SlotMatrix,ap,Nlayer);
                        [Barm,Bpm,Bg,Barm_slot]=FluxCal(time(1:end),Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed,Nt);
                        Br=Bg.rad';
                        Bt=Bg.tan';
                        ForceJmag=ForceJmagLoadHF;% 1000rpm, 800 step
                    case 'FEM'
                        Br=Bg_load_HF.rad;
                        Bt=Bg_load_HF.tan;
                        ForceJmag=ForceJmagLoadHF;% 1000rpm, 800step
                end
            case 'sin'
                switch Flux_method
                    case 'FRM'
                        [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time(1:end),gamma,'sin',I_harm{8},SlotMatrix,ap);
                        [Barm,Bpm,Bg,Barm_slot]=FluxCal(time(1:end),Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed,Nt);
                        Br=Bg.rad';
                        Bt=Bg.tan';
                        ForceJmag=ForceJmagLoad;% 1000rpm 200 step
                    case 'FEM'
                        Br=Bg_load.rad;
                        Bt=Bg_load.tan;
                        ForceJmag=ForceJmagLoad;% 1000rpm 200 step
                end
        end
        Test=TestLoad;
    case 'noload'
        switch Flux_method
            case 'FRM'
                [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time(1:end),gamma,'harm',I_harm{8},SlotMatrix,ap);
                [Barm,Bpm,Bg,Barm_slot]=FluxCal(time(1:end),Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed,Nt);
                Br=Bpm.rad';
                Bt=Bpm.tan';
                ForceJmag=ForceJmagNoload;% 1000rpm 200 step
            case 'FEM'
                Br=Bg_noload.rad;
                Bt=Bg_noload.tan;
                ForceJmag=ForceJmagNoload;% 1000rpm 200 step
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
    =Force_Calculation(Br,Bt,Freq,ForceNum,mu0,L,Ris,Qs,Time,Space,TimeStep,AngleStep,TimeDomain,f0);
%% Frequency Response Function
FRF_Order=[1 2 3 4];
FRF_freq=Freq;
% damp=[6.6,2.7,7.1,7.3]*1e-02;% damping ratio
% damp=zeros(1,length(FRF_freq));
% damp(1:79)=(2.76*10^-5*FRF_freq(1:79)+0.062)*(1/(2*pi));
% damp(80:end)=(log(0.0001*FRF_freq(80:end)+1)+0.062);
damp=log(0.0001*FRF_freq+1)+0.062;
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
Vib_map{1}.mag=Ana.a.mag';
Vib_map{1}.freq=Ana.a.freq';
%% Save data
% save(['E:\OneDrive - i.b.school.nz\GitHub\vibration_for_PMSM\Results\Bg_frm_',Current,num2str(speed),'.mat'],'Bg')
% %% Post Process
% figure(1)
% Plot_Flux_Density(Br,Bt,FourierBr,FourierBt,Time,Space);
% figure(2)
% Plot_Force_Density(F,FourierFr,FourierFt,Time,Space);
% figure(3)
% Plot_Harmonic_2D(Br,Bt,F,Time,TimeStep,Space,AngleStep,f0);
% figure(4)
% Plot_Pcolor_Force_Density(F,FourierFr,FourierFt,Time,Space);
% figure(5)
% Plot_Lumped_Force(Frz,Ftz,Mrz,Time,TimeStep,ToothAngle,Qs,FourierRad,FourierTan,FourierTq);%º”»Î2DÕº–Œ
% figure(6)
% Plot_FRF_Analytical(Mode,FreqResEq,FRF_freq);
% figure(7)
% Plot_Vibration_Analytical(Ana);

% figure(8)
% Plot_Flux_Validate(Bg,Bg_load_HF,AngleStep,f0,Space);
% figure(9)
% Plot_Force_Validate(ForceJmag,ForceIntegral,Time,TimeStep,ToothAngle,Qs,f0);
% figure(10)
% Plot_FRF_Validate(FRF_Order,FreqResEq,FreqResWave,FRF_freq);
% figure(11)
% Plot_speed=1000;
% Plot_Vibration_Validate(Vib_map,Test,f_min,f_max,Plot_speed,speed);