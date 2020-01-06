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
FRF_method='equation' % equation, Wave Excitation, Tooth Excitation
% =================================================================
speed_min=300;speed_max=1500;speed_step=100;
speed=speed_min:speed_step:speed_max;

Force_wave=cell(1,length(speed));
Force_map=cell(1,length(speed));
Vib_map=cell(1,length(speed));
for i=1:length(speed)
    f0=p*speed(i)/60;% fundamental electrical frequncy
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
                    [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time(1:end),gamma,'harm',I_harm{i},SlotMatrix,ap,Nlayer);
                    [Barm,Bpm,Bg,Barm_slot]=FluxCal(time(1:end),Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed(i),Nt);
                    Br=Bg.rad';
                    Bt=Bg.tan';
                case 'sin'
                    [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time(1:end),gamma,'harm',I_harm{i},SlotMatrix,ap,Nlayer);
                    [Barm,Bpm,Bg,Barm_slot]=FluxCal(time(1:end),Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed(i),Nt);
                    Br=Bg.rad';
                    Bt=Bg.tan';
            end
            Test=TestLoad;
        case 'noload'
            [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time(1:end),gamma,'harm',I_harm{i},SlotMatrix,ap,Nlayer);
            [Barm,Bpm,Bg,Barm_slot]=FluxCal(time(1:end),Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed(i),Nt);
            %             [Bpm,Bg]=FluxCal_noload(time(1:end),Bpm_fun,Ipeak,Basic_speed,speed(i),Nt);
            Br=Bg.rad';
            Bt=Bg.tan';
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
        =Force_Calculation_MultiSpeed(Br,Bt,Freq,ForceNum,mu0,L,Ris,Qs,alpha_b0,Space,TimeStep,AngleStep,TimeDomain,f0);
    Force_wave{i}.rad=Frz;
    Force_wave{i}.tan=Ftz;
    Force_wave{i}.tq=Mrz;
    Force_map{i}=Force;
    %% Frequency Response Function
    FRF_freq=Freq;
    %     damp=[6.6,2.7,7.1,7.3]*1e-02;% damping ratio
    %     damp=zeros(1,length(FRF_freq));
    %     damp(1:79)=(2.76*10^-5*FRF_freq(1:79)+0.062)*(1/(2*pi));
    %     damp(80:end)=log(0.0001*FRF_freq(80:end)+1)+0.062;
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
    Vib_map{i}.mag=Ana.a.mag';
    Vib_map{i}.freq=Ana.a.freq';
end
%% Post Process
% save('E:\OneDrive - i.b.school.nz\GitHub\vibration_for_PMSM\Results\Force_wace.mat','Force_wave')
% save('E:\OneDrive - i.b.school.nz\GitHub\vibration_for_PMSM\Results\Force_map.mat','Force_map')
% save('E:\OneDrive - i.b.school.nz\GitHub\vibration_for_PMSM\Results\Vib_map.mat','Vib_map')
% ================= Colormap Plot =================================
% figure(1)
% Plot_Acce_Colormap(speed_min,speed_max,speed_step,Vib_map,custom_colormap);
% figure(2)
% ForceNum=0;
% Plot_Force_Colormap(ForceNum,speed_min,speed_max,speed_step,Force_map,custom_colormap);
% figure(3)
% Plot_speed=1000;
% Plot_Vibration_Validate(Vib_map,Test,f_min,f_max,Plot_speed,speed);