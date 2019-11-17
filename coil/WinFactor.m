%% Winding factor
% 参考许实章的绕组理论
function [kwv,kqv,kyv,ksv]=WinFactor(Qs,yq,n3ph,m,Slot,v,alpha_b0,Slot_Opening_factor)
% Qs=Qs/n3ph;
alfaM=2*pi/Qs;
% A相
A=Slot(1,:);
xA=0;yA=0;
for i=1:numel(A)
    xA=xA+A(i)/abs(A(i))*cos(A(i)*v*alfaM);
    yA=yA+sin(A(i)*v*alfaM);
end
for i=1:1:length(v)
    if xA(i)==0
        phi_av(i)=pi/2;
    else
        phi_av(i)=atan(yA(i)/xA(i))-(xA(i)/abs(xA(i))-1)*pi/2;
    end
end
kqv=sqrt((xA.^2)+(yA.^2))/(Qs/m);%distribution factor
kyv=sin(v*pi*yq/Qs);%pitch factor
ksv=sin(v*alpha_b0/2)./(v*alpha_b0/2);%slot opening factor
if Slot_Opening_factor==1
    kwv=kyv.*kqv.*ksv;
else
    kwv=kyv.*kqv;
    
end