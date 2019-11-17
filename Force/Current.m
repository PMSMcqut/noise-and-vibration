function [Iph,Islot]=Current(n3ph,m,p,Nt,Ipeak,f0,T,time,gamma,type,I_harm,SlotMatrix,ap)
switch type
    case 'sin'
        for j=1:n3ph
            for i=1:m/n3ph
                Iph(1:length(time),i+m/n3ph*(j-1))=Ipeak*sin((2*pi*f0*time)-(p/Nt)*(i-1+(j-1)/(2*n3ph))*2*pi/(m/n3ph)+gamma*pi/180);
            end
        end
    case 'harm'
        time_harm=0:T/(length(I_harm(:,1))-1):T;
        Fs=1/(time_harm(2)-time_harm(1));
        [~,time_loc]=ismember(round(time*Fs),round(time_harm*Fs));
        Iph(1:length(time),:)=I_harm(time_loc,:);
end
Islot=(Iph*SlotMatrix/ap)';
end