%% MMF calculation
function [theta,MMF,MMF_pu,FW_m,VabcPhase]=MMF(Qs,SlotMatrix,Current,t)
theta=1:lcm(360,Qs)*10;
th_p = lcm(360,Qs)/Qs*10;
Ntt_m=0;
mat_tot = Current(:,1)'*SlotMatrix;
for(i=0:Qs-1)
    Ntt_m = mat_tot(i+1)+Ntt_m;
    for(ki=i*th_p+1 : (i+1)*th_p);
        FW_m(ki)=Ntt_m;
    end
end
FW_m= FW_m-0.5*(max(FW_m)+min(FW_m));
MMF=FW_m;
Volt = MMF;
N = length(Volt);
Vf = fft(Volt);                 % Compute FFT
Vdc = Vf(1)/N;
Vac = [Vdc, Vf(2:(N/2+1))*(2/N)];
Vacabs = abs(Vac);              % Amplitude (Magnitude)
VabcPhase = angle(Vac)*180/pi;   % Angle (Phase)
for nu = 1:1000
    if mod (nu ,t* 3)<0.1
        Vacabs(nu+1) =0; % return zero for harmonic of order n*3
    end
    if Vacabs(nu) < 1e-6
        Vacabs(nu) = 0;
    end
end
MMF_pu=Vacabs/max(Vacabs);
end