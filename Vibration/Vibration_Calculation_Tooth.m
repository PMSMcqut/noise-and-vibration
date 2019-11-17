function [Ana,FourierTooth,ForceTooth]=Vibration_Calculation_Tooth(Frz,Ftz,Mrz,FRF,f_min,f_step,f_max,Freq,f0,TimeDomain)
[FourierTooth.rad]=FFT_fun(Frz',TimeDomain.Time',1,f0,1,'1D','fun'); % FFT of Radial force
[FourierTooth.tan]=FFT_fun(Ftz',TimeDomain.Time',1,f0,1,'1D','fun');
[FourierTooth.tq]=FFT_fun(Mrz',TimeDomain.Time',1,f0,1,'1D','fun');

[~,time_loc]=ismember(Freq,FourierTooth.rad.P.Frequency);
ForceTooth.rad=FourierTooth.rad.P.Amplitude(time_loc,:).*(cos(FourierTooth.rad.P.Phase(time_loc,:)*pi/180)+1i*sin(FourierTooth.rad.P.Phase(time_loc,:)*pi/180));
ForceTooth.tan=FourierTooth.tan.P.Amplitude(time_loc,:).*(cos(FourierTooth.tan.P.Phase(time_loc,:)*pi/180)+1i*sin(FourierTooth.tan.P.Phase(time_loc,:)*pi/180));
ForceTooth.tq=FourierTooth.tq.P.Amplitude(time_loc,:).*(cos(FourierTooth.tq.P.Phase(time_loc,:)*pi/180)+1i*sin(FourierTooth.tq.P.Phase(time_loc,:)*pi/180));

def.rad=ForceTooth.rad'.*FRF.rad(:,1:length(Freq));
def.tan=ForceTooth.tan'.*FRF.tan(:,1:length(Freq));
def.tq=ForceTooth.tq'.*FRF.tq(:,1:length(Freq));





Ana.def.complex=sum(def.rad)+sum(def.tan)+sum(def.tq);
Ana.def.freq=f_min:f_step:f_max;

for i=1:length(Ana.def.freq)
    Ana.def.positive(i)=sum(Ana.def.complex(abs(Freq)==Ana.def.freq(i)));
end
Ana.def.mag=abs(Ana.def.positive);
Ana.def.phase=angle(Ana.def.positive)*180/pi;
Ana.def.order=round(Ana.def.freq/f0);
% ================= vecolity =======================================
Ana.v.freq=Ana.def.freq;
Ana.v.positive=1i.*(2*pi*Ana.v.freq).*Ana.def.positive;
Ana.v.mag=abs(Ana.v.positive);
Ana.v.phase=angle(Ana.v.positive);
% ================= acceleration ===================================
Ana.a.freq=Ana.def.freq;
Ana.a.positive=-(2*pi*Ana.a.freq).^2.*Ana.def.positive;
Ana.a.mag=abs(Ana.a.positive);
Ana.a.phase=angle(Ana.a.positive);
end