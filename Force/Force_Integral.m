function [ForceIntegral]=Force_Integral(F,L,Ris,Qs,alpha_b0,Space,TimeStep)
% 0度和360度所在的位置是重合的
% 0秒和最后一秒也是重合的
theta_a=Space';% rotor position when force integral
DeltaTheta_a=360/Qs/2;% angle between the two adjacent tooth
theta=theta_a*pi/180;
DeltaTheta=DeltaTheta_a*pi/180*(1-alpha_b0);
for q=1:Qs
    thetaZ_a=360*(q-1/2)/Qs;
    thetaZ=thetaZ_a*pi/180;
    frz=(F.rad.*cos(thetaZ-theta)+F.tan.*sin(thetaZ-theta))*L*Ris;
    ftz=(F.tan.*cos(thetaZ-theta)-F.rad.*sin(thetaZ-theta))*L*Ris;
    Mz=(F.rad.*sin(thetaZ-theta)+F.tan.*(1-cos(thetaZ-theta)))*L*Ris^2;
    x1=(thetaZ_a-DeltaTheta_a);
    x2=(thetaZ_a+DeltaTheta_a);
    ForceIntegral.rad(q,:)=trapz(frz(find(theta_a==x1):find(theta_a==x2),:))*pi/180;
    ForceIntegral.tan(q,:)=trapz(ftz(find(theta_a==x1):find(theta_a==x2),:))*pi/180;
    ForceIntegral.tq(q,:)=trapz(Mz(find(theta_a==x1):find(theta_a==x2),:))*pi/180;
end
ForceIntegral.rad=ForceIntegral.rad(:,1:TimeStep);
ForceIntegral.tan=ForceIntegral.tan(:,1:TimeStep);
ForceIntegral.tq=ForceIntegral.tq(:,1:TimeStep);
end
