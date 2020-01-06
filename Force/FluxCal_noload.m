function [Bpm,Bg]=FluxCal_noload(time,Bpm_fun,Ipeak,Basic_speed,speed,Nt)
[~,n]=size(Bpm_fun.rad);
for t=1:length(time)
    %     for j=1:n/Nt
    %         Bpm.rad(t,j)=sign(Ipeak)*Bpm_fun.rad{j}(abs(Ipeak),time(t)*speed/Basic_speed);
    %         Bpm.tan(t,j)=sign(Ipeak)*Bpm_fun.tan{j}(abs(Ipeak),time(t)*speed/Basic_speed);
    %     end
    Bpm.rad(t,:)=sign(Ipeak)*cell2mat(cellfun(@(x) x(abs(Ipeak),time(t)*speed/Basic_speed),Bpm_fun.rad(1:n/Nt),'UniformOutput',false));
    Bpm.tan(t,:)=sign(Ipeak)*cell2mat(cellfun(@(x) x(abs(Ipeak),time(t)*speed/Basic_speed),Bpm_fun.tan(1:n/Nt),'UniformOutput',false));
end
Bg.rad=Bpm.rad;
Bg.tan=Bpm.tan;
Bg.rad=repmat(Bg.rad,1,3);
Bg.tan=repmat(Bg.tan,1,3);
Bg.rad(:,size(Bg.rad,2)+1)=Bg.rad(:,1);
Bg.tan(:,size(Bg.tan,2)+1)=Bg.tan(:,1);
end