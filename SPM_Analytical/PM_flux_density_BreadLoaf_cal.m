function [Brn,Bthn,Brn1,Btn1,Bpm_r,Bpms_r,Rmj,ang,theta]=PM_flux_density_BreadLoaf_cal(NB,Mtype,Br,p,alpha_p,mu0,mur,R,Rm,hm,Rs,Rr,lambda_r,lambda_t,f,t,delta_d)

%% PM flux density without slot
	n=1:2:NB;
    xx=9;
    theta_b=linspace(0-pi/2,2*pi-pi/2,360);
    for j=1:xx
        alpha_pj=alpha_p/xx;
        theta(j)=(xx-2*j+1)/2*alpha_pj*pi/(p);
        syms x
        eqn=cos(theta(j))-(x^2+delta_d^2-(Rm-delta_d)^2)/(2*x*delta_d);
        x=eval(solve(eval(eqn)));
        Rmj(j)=max(x);
        hmj(j)=Rmj(j)-Rr;
    RmRs=Rmj(j)/Rs;
	RrRm=Rr/Rmj(j);
	RrRs=Rr/Rs;
	RRs=R/Rs;
	RmR=Rmj(j)/R;
	if Mtype=='R'
        Mn(j,:)=Br*4./(mu0*n*pi).*sin(n*pi*alpha_pj/2);
        A3n(j,:)=n*p;
	elseif Mtype=='P'
        A1n(j,:)=sin((n*p+1)*alpha_pj*pi/(2*p))./((n*p+1)*alpha_pj*pi/(2*p));
        A2n(j,:)=sin((n*p-1)*alpha_pj*pi/(2*p))./((n*p-1)*alpha_pj*pi/(2*p));
        Mrn(j,:)=Br/mu0*alpha_pj*(A1n(j,:)+A2n(j,:));
        Mthn(j,:)=Br/mu0*alpha_pj*(A1n(j,:)-A2n(j,:));
        Mn(j,:)=Mrn(j,:)+n*p.*Mthn(j,:);
        A3n(j,:)=(n*p-1./(n*p)).*Mrn(j,:)./Mn(j,:)+1./(n*p);
	end
	Brn(j,:)=mu0*Mn(j,:)/mur.*(n*p)./((n*p).^2-1).*(RRs.^(n*p-1).*RmRs.^(n*p+1)+RmR.^(n*p+1)).*...
         (A3n(j,:)-1+2*RrRm.^(n*p+1)-(A3n(j,:)+1).*RrRm.^(2*n*p))./((mur+1)/mur*(1-RrRs.^(2*n*p))-...
         (mur-1)/mur*(RmRs.^(2*n*p)-RrRm.^(2*n*p)));
	
	Bthn(j,:)=mu0*Mn(j,:)/mur.*(n*p)./((n*p).^2-1).*(-RRs.^(n*p-1).*RmRs.^(n*p+1)+RmR.^(n*p+1)).*...
         (A3n(j,:)-1+2*RrRm.^(n*p+1)-(A3n(j,:)+1).*RrRm.^(2*n*p))./((mur+1)/mur*(1-RrRs.^(2*n*p))-...
         (mur-1)/mur*(RmRs.^(2*n*p)-RrRm.^(2*n*p)));
    Brn1=sum(Brn,1);
    Btn1=sum(Bthn,1);
    end
    for w=1:length(t)
        for j=1:xx
	    ang=(p*theta_b'-2*pi*f*t(w)-p*theta(j))*n;
	    Bpm_r(:,w)=cos(ang)*Brn1';
	    Bpm_t(:,w)=sin(ang)*Btn1';
        end
%% PM flux density with slot
    Bpms(:,w)=(Bpm_r(:,w)+1i*Bpm_t(:,w)).*conj(lambda_r+1i*lambda_t);
    Bpms_r=real(Bpms);
    Bpms_t=imag(Bpms);
    end
end
