function [Bpm_r,Bpm_t,Bpms,Bpms_r,Bpms_t,theta_b,Brn,ang]=PM_flux_density_cal(NB,Mtype,Br,p,alpha_p,mu0,mur,R,Rm,Rs,Rr,lambda_r,lambda_t,f,t)
	RmRs=Rm/Rs;
	RrRm=Rr/Rm;
	RrRs=Rr/Rs;
	RRs=R/Rs;
	RmR=Rm/R;
%% PM flux density without slot
	n=1:2:NB;
	if Mtype=='R'
        Mn=Br*4./(mu0*n*pi).*sin(n*pi*alpha_p/2);
        A3n=n*p;
	elseif Mtype=='P'
        A1n=sin((n*p+1)*alpha_p*pi/(2*p))./((n*p+1)*alpha_p*pi/(2*p));
        A2n=sin((n*p-1)*alpha_p*pi/(2*p))./((n*p-1)*alpha_p*pi/(2*p));
        Mrn=Br/mu0*alpha_p*(A1n+A2n);
        Mthn=Br/mu0*alpha_p*(A1n-A2n);
        Mn=Mrn+n*p.*Mthn;
        A3n=(n*p-1./(n*p)).*Mrn./Mn+1./(n*p);
	end
	Brn=mu0*Mn/mur.*(n*p)./((n*p).^2-1).*(RRs.^(n*p-1).*RmRs.^(n*p+1)+RmR.^(n*p+1)).*...
         (A3n-1+2*RrRm.^(n*p+1)-(A3n+1).*RrRm.^(2*n*p))./((mur+1)/mur*(1-RrRs.^(2*n*p))-...
         (mur-1)/mur*(RmRs.^(2*n*p)-RrRm.^(2*n*p)));
	
	Bthn=mu0*Mn/mur.*(n*p)./((n*p).^2-1).*(-RRs.^(n*p-1).*RmRs.^(n*p+1)+RmR.^(n*p+1)).*...
         (A3n-1+2*RrRm.^(n*p+1)-(A3n+1).*RrRm.^(2*n*p))./((mur+1)/mur*(1-RrRs.^(2*n*p))-...
         (mur-1)/mur*(RmRs.^(2*n*p)-RrRm.^(2*n*p)));
    
%     theta=[-pi/2/p:thetas/N:2*pi/p-pi/2/p]*p;
    theta_b=linspace(0-pi/2,2*pi-pi/2,360);
 for w=1:length(t)
	ang=(p*theta_b'-2*pi*f*t(w))*n;
	Bpm_r(:,w)=cos(ang)*Brn';
	Bpm_t(:,w)=sin(ang)*Bthn';
%% PM flux density with slot
    Bpms(:,w)=(Bpm_r(:,w)+1i*Bpm_t(:,w)).*conj(lambda_r+1i*lambda_t);
    Bpms_r=real(Bpms);
    Bpms_t=imag(Bpms);
 end
end
