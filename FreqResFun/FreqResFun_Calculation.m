function [FreqResEq,FreqResWave,FreqResTooth]=FreqResFun_Calculation(Mode,FRF_freq,FreqResWave,FreqResTooth,StaDef,f_modal,damp)
% =============== Analytical ======================================
FRF_Ana.rad=@(ModeNum,freq) StaDef.rad(Mode==ModeNum)*(1./(1-(freq/f_modal(Mode==ModeNum)).^2+1i*2*damp(Mode==ModeNum)*freq/f_modal(Mode==ModeNum)));
FRF_Ana.tan=@(ModeNum,freq) StaDef.tan(Mode==ModeNum)*(1./(1-(freq/f_modal(Mode==ModeNum)).^2+1i*2*damp(Mode==ModeNum)*freq/f_modal(Mode==ModeNum)));
FRF_Ana.tq=@(ModeNum,freq) StaDef.tq(Mode==ModeNum)*(1./(1-(freq/f_modal(Mode==ModeNum)).^2+1i*2*damp(Mode==ModeNum)*freq/f_modal(Mode==ModeNum)));
% FRF_Ana.rad=@(ModeNum,freq) StaDef.rad(Mode==ModeNum)*(1./(1-(freq/f_modal(Mode==ModeNum)).^2+1i*2*damp.*freq/f_modal(Mode==ModeNum)));
% FRF_Ana.tan=@(ModeNum,freq) StaDef.tan(Mode==ModeNum)*(1./(1-(freq/f_modal(Mode==ModeNum)).^2+1i*2*damp.*freq/f_modal(Mode==ModeNum)));
% FRF_Ana.tq=@(ModeNum,freq) StaDef.tq(Mode==ModeNum)*(1./(1-(freq/f_modal(Mode==ModeNum)).^2+1i*2*damp.*freq/f_modal(Mode==ModeNum)));
for i=1:length(Mode)
    FreqResEq.rad.complex(:,i)=FRF_Ana.rad(Mode(i),FRF_freq);
    FreqResEq.tan.complex(:,i)=FRF_Ana.tan(Mode(i),FRF_freq);
    FreqResEq.tq.complex(:,i)=FRF_Ana.tq(Mode(i),FRF_freq);
end
FreqResEq.rad.amp=abs(FreqResEq.rad.complex);
FreqResEq.tan.amp=abs(FreqResEq.tan.complex);
FreqResEq.tq.amp=abs(FreqResEq.tq.complex);
FreqResEq.rad.pha=angle(FreqResEq.rad.complex);
FreqResEq.tan.pha=angle(FreqResEq.tan.complex);
FreqResEq.tq.pha=angle(FreqResEq.tq.complex);
% =============== Wave Exciation ======================================
FreqResWave.rad.complex=FreqResWave.rad.amp.*(cos(FreqResWave.rad.pha*pi/180)+1i*sin(FreqResWave.rad.pha*pi/180));
FreqResWave.tan.complex=FreqResWave.tan.amp.*(cos(FreqResWave.tan.pha*pi/180)+1i*sin(FreqResWave.tan.pha*pi/180));
FreqResWave.tq.complex=FreqResWave.tq.amp.*(cos(FreqResWave.tq.pha*pi/180)+1i*sin(FreqResWave.tq.pha*pi/180));
% =============== Tooth Exciation ======================================
FreqResTooth.rad.complex=FreqResTooth.rad.amp.*(cos(FreqResTooth.rad.pha*pi/180)+1i*sin(FreqResTooth.rad.pha*pi/180));
FreqResTooth.tan.complex=FreqResTooth.tan.amp.*(cos(FreqResTooth.tan.pha*pi/180)+1i*sin(FreqResTooth.tan.pha*pi/180));
FreqResTooth.tq.complex=FreqResTooth.tq.amp.*(cos(FreqResTooth.tq.pha*pi/180)+1i*sin(FreqResTooth.tq.pha*pi/180));
end