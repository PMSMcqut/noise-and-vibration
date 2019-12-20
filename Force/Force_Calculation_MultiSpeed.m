function [F,Frz,Ftz,Mrz,ForceIntegral,FourierBr,FourierBt,FourierFr,FourierFt,FourierRad,FourierTan,FourierTq,Force]...
    =Force_Calculation_MultiSpeed(Br,Bt,Freq,ForceNum,mu0,L,Ris,Qs,alpha_b0,Space,TimeStep,AngleStep,TimeDomain,f0)
%% Force Calculation
%======================= flux density ==============================
% imported
% ====================== force density =============================
F.rad=(Br.^2-Bt.^2)/(2*mu0);
F.tan=Br.*Bt/mu0;
% ====================== lumped force =============================
[ForceIntegral]=Force_Integral(F,L,Ris,Qs,alpha_b0,Space,TimeStep);% Calcualted by Integral Method

%% Harmonic analysis
% ====================== flux density ==============================
[FourierBr]=FFT_fun(Br(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
[FourierBt]=FFT_fun(Bt(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
% ====================== force density =============================
[FourierFr]=FFT_fun(F.rad(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
[FourierFt]=FFT_fun(F.tan(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
% ====================== lumped force =============================
Frz=ForceIntegral.rad;
Ftz=ForceIntegral.tan;
Mrz=ForceIntegral.tq;
%----------------------- FFT --------------------------------------
[FourierRad]=FFT_fun(Frz,TimeDomain.Time,TimeDomain.ToothAngle,f0,5000,'2D','fun'); % FFT of Radial force
[~,time_loc]=ismember(Freq,round(FourierRad.P.Frequency));
[~,angle_loc]=ismember(ForceNum,FourierRad.P.SpaceOrder);
Force.freq=FourierRad.P.Frequency(time_loc);
Force.rad=FourierRad.P.Amplitude(angle_loc,time_loc).*(cos(FourierRad.P.Phase(angle_loc,time_loc)*pi/180)+1i*sin(FourierRad.P.Phase(angle_loc,time_loc)*pi/180));

[FourierTan]=FFT_fun(Ftz,TimeDomain.Time,TimeDomain.ToothAngle,f0,5000,'2D','fun'); % FFT of Tangential force
[~,time_loc]=ismember(Freq,round(FourierTan.P.Frequency));
[~,angle_loc]=ismember(ForceNum,FourierTan.P.SpaceOrder);
Force.tan=FourierTan.P.Amplitude(angle_loc,time_loc).*(cos(FourierTan.P.Phase(angle_loc,time_loc)*pi/180)+1i*sin(FourierTan.P.Phase(angle_loc,time_loc)*pi/180));

[FourierTq]=FFT_fun(Mrz,TimeDomain.Time,TimeDomain.ToothAngle,f0,5000,'2D','fun'); % FFT of Torque
[~,time_loc]=ismember(Freq,round(FourierTq.P.Frequency));
[~,angle_loc]=ismember(ForceNum,FourierTq.P.SpaceOrder);
Force.tq=FourierTq.P.Amplitude(angle_loc,time_loc).*(cos(FourierTq.P.Phase(angle_loc,time_loc)*pi/180)+1i*sin(FourierTq.P.Phase(angle_loc,time_loc)*pi/180));
end