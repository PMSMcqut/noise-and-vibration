function [F,Frz,Ftz,Mrz,ForceIntegral,FourierBr,FourierBt,FourierFr,FourierFt,FourierRad,FourierTan,FourierTq]...
    =HighFreqForceRebulid(Br,Bt,mu0,L,Ris,Qs,Time,Space,TimeStep,AngleStep,TimeDomain,f0)
%% Force Calculation
%======================= flux density ==============================
% imported
% ====================== force density =============================
F.rad=(Br.^2-Bt.^2)/(2*mu0);
F.tan=Br.*Bt/mu0;
% ====================== lumped force =============================
[ForceIntegral]=Force_Integral(F,L,Ris,Qs,Time,Space,TimeStep,AngleStep);% Calcualted by Integral Method

%% Harmonic analysis
% ====================== flux density ==============================
[FourierBr]=FFT_fun(Br(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
[FourierBt]=FFT_fun(Bt(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
% ====================== force density =============================
[FourierFr]=FFT_fun(F.rad(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
[FourierFt]=FFT_fun(F.tan(1:AngleStep,1:TimeStep),TimeDomain.Time,TimeDomain.Space,f0,5000,'2D','fun');
% ====================== lumped force =============================
Frz=ForceIntegral.Fr;
Ftz=ForceIntegral.Ft;
Mrz=ForceIntegral.M;
[FourierRad]=FFT_fun(Frz,TimeDomain.Time,TimeDomain.ToothAngle,f0,5000,'2D','fun'); % FFT of Radial force
[FourierTan]=FFT_fun(Ftz,TimeDomain.Time,TimeDomain.ToothAngle,f0,5000,'2D','fun'); % FFT of Tangential force
[FourierTq]=FFT_fun(Mrz,TimeDomain.Time,TimeDomain.ToothAngle,f0,5000,'2D','fun'); % FFT of Torque
end