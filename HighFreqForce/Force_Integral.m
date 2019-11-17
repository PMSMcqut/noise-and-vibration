function [ForceIntegral]=Force_Integral(F,L,Ris,Qs,Time,Space,TimeStep,AngleStep)
% 0度和360度所在的位置是重合的
% 0秒和最后一秒也是重合的
theta_a=Space';% rotor position when force integral
DeltaTheta_a=360/Qs/2;% angle between the two adjacent tooth
theta=theta_a*pi/180;
DeltaTheta=DeltaTheta_a*pi/180;%*(1-alpha_b0);
for q=1:Qs
    thetaZ_a=360*(q-1/2)/Qs;
    thetaZ=thetaZ_a*pi/180;
    frz=(F.rad.*cos(thetaZ-theta)+F.tan.*sin(thetaZ-theta))*L*Ris;
    ftz=(F.tan.*cos(thetaZ-theta)-F.rad.*sin(thetaZ-theta))*L*Ris;
    Mz=(F.rad.*sin(thetaZ-theta)+F.tan.*(1-cos(thetaZ-theta)))*L*Ris^2;
    x1=(thetaZ_a-DeltaTheta_a);
    x2=(thetaZ_a+DeltaTheta_a);
    ForceIntegral.Fr(q,:)=trapz(frz(find(theta_a==x1):find(theta_a==x2),:))*pi/180;
    ForceIntegral.Ft(q,:)=trapz(ftz(find(theta_a==x1):find(theta_a==x2),:))*pi/180;
    ForceIntegral.M(q,:)=trapz(Mz(find(theta_a==x1):find(theta_a==x2),:))*pi/180;
end
ForceIntegral.Fr=ForceIntegral.Fr(:,1:TimeStep);
ForceIntegral.Ft=ForceIntegral.Ft(:,1:TimeStep);
ForceIntegral.M=ForceIntegral.M(:,1:TimeStep);
end
