function [Barm_r,Barm_t,Barms_r,Barms_t,theta_arm]=Armature_flux_density_cal(mu0,Qs,p,Rs,Rm,R,Rr,bo,n,f,t,Ns,a,I,lambda_r,lambda_t)
alpha0=2*pi/Qs;
alphay=bo/Rs;
k=1:1:100;
Bkr=-4*mu0*Rs*Ns/(pi*a*bo*R)./k.*(Rs/R).^k.*(((R/Rr).^(2*k)+1)./((Rs/Rr).^(2*k)-1)).*sin(k*alphay/2).*sin(k*alpha0/2);
Bkt=4*mu0*Rs*Ns/(pi*a*bo*R)./k.*(Rs/R).^k.*(((R/Rr).^(2*k)-1)./((Rs/Rr).^(2*k)-1)).*sin(k*alphay/2).*sin(k*alpha0/2);
theta_arm=linspace(0+pi/12,2*pi+pi/12,360);
for w=1:length(t)
for m=1:1:3
for i=1:length(k)
    for j=1:2
    tempr1(j,:)=(-1).^(j-1).*cos(i*(theta_arm-(m-1)*2*pi/3-(j-1)*alpha0));
    temp_r(i,:)=sum(tempr1,1);
    tempt1(j,:)=(-1).^(j-1).*sin(i*(theta_arm-(m-1)*2*pi/3-(j-1)*alpha0));
    temp_t(i,:)=sum(tempt1,1);
    end
    Bark(i,:)=Bkr(i)*(1+(-1)^(i+1))*temp_r(i,:);
    Batk(i,:)=Bkt(i)*(1+(-1)^(i+1))*temp_t(i,:);
end
Br3(:,m)=sum(Bark,1)*I*sin(2*pi*f*t(w)-(m-1)*2*pi/3);
Bt3(:,m)=sum(Batk,1)*I*sin(2*pi*f*t(w)-(m-1)*2*pi/3);
end
Barm_r(:,w)=sum(Br3,2);
Barm_t(:,w)=sum(Bt3,2);
%% armature flux density with slot
    Barms(:,w)=(Barm_r(:,w)+1i*Barm_t(:,w)).*conj(lambda_r+1i*lambda_t);
    Barms_r=real(Barms);
    Barms_t=imag(Barms);
end
end
