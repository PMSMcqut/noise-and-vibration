function [Barm,Bpm,Bg]=FluxCal(time,Barm_fun,Bpm_fun,Islot,Basic_speed,speed)
[m,n]=size(Barm_fun.rad);
for t=1:length(time)
    for i=1:m
        for j=1:n
            Barm_slot.rad(i,j)=Barm_fun.rad{i,j}(Islot(i,t),time(t)*speed/Basic_speed);
            Barm_slot.tan(i,j)=Barm_fun.tan{i,j}(Islot(i,t),time(t)*speed/Basic_speed);
        end
        Barm.rad(t,:)=sum(Barm_slot.rad,1);
        Barm.tan(t,:)=sum(Barm_slot.tan,1);
    end
    for j=1:n
        Bpm.rad(t,j)=Bpm_fun.rad{j}(Islot(i,t),time(t)*speed/Basic_speed);
        Bpm.tan(t,j)=Bpm_fun.tan{j}(Islot(i,t),time(t)*speed/Basic_speed);
    end
end
Bg.rad=Barm.rad+Bpm.rad;
Bg.tan=Barm.tan+Bpm.tan;
Bg.rad(:,size(Bg.rad,2)+1)=Bg.rad(:,1);
Bg.tan(:,size(Bg.tan,2)+1)=Bg.tan(:,1);
end