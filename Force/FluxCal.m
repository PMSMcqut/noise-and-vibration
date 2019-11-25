function [Barm,Bpm,Bg,Barm_slot]=FluxCal(time,Barm_fun,Bpm_fun,Ipeak,Islot,Basic_speed,speed,Nt)
[m,n]=size(Barm_fun.rad);
for t=1:length(time)
    for i=1:m
        Barm_slot.rad(i,:)=sign(Islot(i,t))*cell2mat(cellfun(@(x) x(abs(Islot(i,t)),time(t)*speed/Basic_speed),Barm_fun.rad(i,1:n/Nt),'UniformOutput',false));
        Barm_slot.tan(i,:)=sign(Islot(i,t))*cell2mat(cellfun(@(x) x(abs(Islot(i,t)),time(t)*speed/Basic_speed),Barm_fun.tan(i,1:n/Nt),'UniformOutput',false));
        %         for j=1:n/Nt
        %             Barm_slot.rad(i,j)=sign(Islot(i,t))*Barm_fun.rad{i,j}(abs(Islot(i,t)),time(t)*speed/Basic_speed);
        %             Barm_slot.tan(i,j)=sign(Islot(i,t))*Barm_fun.tan{i,j}(abs(Islot(i,t)),time(t)*speed/Basic_speed);
        %         end
        Barm.rad(t,:)=sum(Barm_slot.rad,1);
        Barm.tan(t,:)=sum(Barm_slot.tan,1);
    end
    %     for j=1:n/Nt
    %         Bpm.rad(t,j)=sign(Ipeak)*Bpm_fun.rad{j}(abs(Ipeak),time(t)*speed/Basic_speed);
    %         Bpm.tan(t,j)=sign(Ipeak)*Bpm_fun.tan{j}(abs(Ipeak),time(t)*speed/Basic_speed);
    %     end
    Bpm.rad(t,:)=sign(Ipeak)*cell2mat(cellfun(@(x) x(abs(Ipeak),time(t)*speed/Basic_speed),Bpm_fun.rad(1:n/Nt),'UniformOutput',false));
    Bpm.tan(t,:)=sign(Ipeak)*cell2mat(cellfun(@(x) x(abs(Ipeak),time(t)*speed/Basic_speed),Bpm_fun.tan(1:n/Nt),'UniformOutput',false));
end
Bg.rad=Barm.rad+Bpm.rad;
Bg.tan=Barm.tan+Bpm.tan;
Bg.rad=repmat(Bg.rad,1,3);
Bg.tan=repmat(Bg.tan,1,3);
Bg.rad(:,size(Bg.rad,2)+1)=Bg.rad(:,1);
Bg.tan(:,size(Bg.tan,2)+1)=Bg.tan(:,1);
end