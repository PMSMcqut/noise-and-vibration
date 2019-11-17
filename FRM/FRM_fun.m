function [Iph,Islot,Barm_frm_t,Bg_frm_t,Bpm_fem_t]=FRM_fun(Qs,p,m,n3ph,Nt,ap,f0,Ipeak,gamma,time,SlotMatrix,Basic_Fun,Basic_I,Bpm_fem)
% 声明变量大小
space_step=size(Basic_Fun{1}.rad,2);
time_step=size(Basic_Fun{1}.rad,1);
theta_s=360; % (0:360/space_step:360-360/space_step), mechanical stator angle
Basic_speed=1000;
Basic_T=1/(p*Basic_speed/60);
Basic_time=(0:Basic_T/time_step:Basic_T-Basic_T/time_step)';
theta_r=360/p; % (0:360/time_step:360-360/time_step)'/p, mechanical rotor angle
temp=cell(1,length(Basic_I));
[Iph]=Current(n3ph,m,p,Nt,Ipeak,f0,time,gamma);
Islot=Iph*SlotMatrix/ap;% equivalent current of one conductor in real
for j=1:Nt
    for q=1:Qs/2/Nt % 这两个循环遍历所有槽
        for i=1:length(Basic_I)
            % radial flux density
            temp{i}.rad=[Basic_Fun{i}.rad(:,space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs+1:end),Basic_Fun{i}.rad(:,1:space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs)];
            temp{i}.rad=[temp{i}.rad(time_step-(q-1)*(theta_s/Qs/(theta_r/time_step))+1:end,:);temp{i}.rad(1:time_step-(q-1)*(theta_s/Qs/(theta_r/time_step)),:)];
            Bslot_temp.rad(i,:)=interp1(Basic_time,temp{i}.rad,time,'spline');
            % tangential flux density
            temp{i}.tan=[Basic_Fun{i}.tan(:,space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs+1:end),Basic_Fun{i}.tan(:,1:space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs)];
            temp{i}.tan=[temp{i}.tan(time_step-(q-1)*(theta_s/Qs/(theta_r/time_step))+1:end,:);temp{i}.tan(1:time_step-(q-1)*(theta_s/Qs/(theta_r/time_step)),:)];
            Bslot_temp.tan(i,:)=interp1(Basic_time,temp{i}.tan,time,'spline');
        end
        Bslot.rad(q+(j-1)*Qs/(2*Nt),:)=sign(Islot(q+(j-1)*Qs/(2*Nt)))*interp1(Basic_I,Bslot_temp.rad,abs(Islot(q+(j-1)*Qs/(2*Nt))),'spline');
        Bslot.tan(q+(j-1)*Qs/(2*Nt),:)=sign(Islot(q+(j-1)*Qs/(2*Nt)))*interp1(Basic_I,Bslot_temp.tan,abs(Islot(q+(j-1)*Qs/(2*Nt))),'spline');
    end
end 
% Bslot_temp=struct('rad',zeros(length(Basic_I),360),'tan',zeros(length(Basic_I),360));
% Bslot=struct('rad',zeros(Qs,360),'tan',zeros(Qs,360));
% Barm_frm_t=struct('rad',[],'tan',[]);
% Bpm_fem_t=struct('rad',[],'tan',[]);
% Bg_frm_t=struct('rad',[],'tan',[]);
% for j=1:Nt
%     for q=1:Qs/2/Nt % 这两个循环遍历所有槽
%         for i=1:length(Basic_I)
%             % radial flux density
%             temp=[Basic_Fun{i}.rad(:,space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs+1:end),Basic_Fun{i}.rad(:,1:space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs)];
%             temp=[temp(time_step-(q-1)*(theta_s/Qs/(theta_r/time_step))+1:end,:);temp(1:time_step-(q-1)*(theta_s/Qs/(theta_r/time_step)),:)];
%             Bslot_temp.rad(i,:)=griddedInterpolant(Basic_time,temp,time,'spline');
%             % tangential flux density
%             temp=[Basic_Fun{i}.tan(:,space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs+1:end),Basic_Fun{i}.tan(:,1:space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs)];
%             temp=[temp(time_step-(q-1)*(theta_s/Qs/(theta_r/time_step))+1:end,:);temp(1:time_step-(q-1)*(theta_s/Qs/(theta_r/time_step)),:)];
%             Bslot_temp.tan(i,:)=interp1(Basic_time,temp,time,'spline');
%         end
%         Bslot.rad(q+(j-1)*Qs/(2*Nt),:)=sign(Islot(q+(j-1)*Qs/(2*Nt)))*interp1(Basic_I,Bslot_temp.rad,abs(Islot(q+(j-1)*Qs/(2*Nt))),'spline');
%         Bslot.tan(q+(j-1)*Qs/(2*Nt),:)=sign(Islot(q+(j-1)*Qs/(2*Nt)))*interp1(Basic_I,Bslot_temp.tan,abs(Islot(q+(j-1)*Qs/(2*Nt))),'spline');
%     end
% end 
Barm_frm_t.rad=sum(Bslot.rad,1);
Barm_frm_t.tan=sum(Bslot.tan,1);
Bpm_fem_t.rad=interp1(Basic_time,Bpm_fem.rad,time,'spline');
Bpm_fem_t.tan=interp1(Basic_time,Bpm_fem.tan,time,'spline');
Bg_frm_t.rad=Barm_frm_t.rad+Bpm_fem_t.rad;
Bg_frm_t.tan=Barm_frm_t.tan+Bpm_fem_t.tan;
end