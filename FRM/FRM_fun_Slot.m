clear;clc;
load('Basic_Fun.mat');% conductor:Nc, current in one conductor: Basic_I, two slot
load('Bpm_fem.mat');
Basic_I=0.2:0.2:14; % equivalent current of one conductor for basic function
Qs=36;p=3;
Nt=gcd(Qs,p); % number of unit motor
space_step=size(Basic_Fun{1}.rad,2);
time_step=size(Basic_Fun{1}.rad,1);
theta_s=360; % (0:360/space_step:360-360/space_step), mechanical stator angle
theta_r=360/p; % (0:360/time_step:360-360/time_step)'/p, mechanical rotor angle
Basic_speed=1000;
Basic_T=1/(p*Basic_speed/60);
Basic_Time=(0:Basic_T/time_step:Basic_T-Basic_T/time_step)';
Basic_slot=cell(Qs/2,length(Basic_I));
for j=1:Nt
    for q=1:Qs/2/Nt % 这两个循环遍历所有槽
        for i=1:length(Basic_I)
            % radial flux density
            Basic_slot{q+(j-1)*Qs/(2*Nt),i}.rad=[Basic_Fun{i}.rad(:,space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs+1:end),Basic_Fun{i}.rad(:,1:space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs)];
            Basic_slot{q+(j-1)*Qs/(2*Nt),i}.rad=[Basic_slot{q+(j-1)*Qs/(2*Nt),i}.rad(time_step-(q-1)*(theta_s/Qs/(theta_r/time_step))+1:end,:);Basic_slot{q+(j-1)*Qs/(2*Nt),i}.rad(1:time_step-(q-1)*(theta_s/Qs/(theta_r/time_step)),:)];
            % tangential flux density
            Basic_slot{q+(j-1)*Qs/(2*Nt),i}.tan=[Basic_Fun{i}.tan(:,space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs+1:end),Basic_Fun{i}.tan(:,1:space_step-(q+(j-1)*Qs/(2*Nt)-1)*theta_s/Qs)];
            Basic_slot{q+(j-1)*Qs/(2*Nt),i}.tan=[Basic_slot{q+(j-1)*Qs/(2*Nt),i}.tan(time_step-(q-1)*(theta_s/Qs/(theta_r/time_step))+1:end,:);Basic_slot{q+(j-1)*Qs/(2*Nt),i}.tan(1:time_step-(q-1)*(theta_s/Qs/(theta_r/time_step)),:)];
        end
    end
end
[m,n]=size(Basic_slot);
Barm_theta_rad=cell(m,360);
Barm_theta_tan=cell(m,360);
Bpm_theta_rad=cell(1,360);
Bpm_theta_tan=cell(1,360);
for k=1:m
    for i=1:n
        for j=1:size(Basic_slot{k}.rad,2)
            Barm_theta_rad{k,j}(i,:)=Basic_slot{k,i}.rad(:,j);
            Barm_theta_tan{k,j}(i,:)=Basic_slot{k,i}.tan(:,j);            
        end
    end
end
for jj=1:size(Bpm_fem.rad,2)
    Bpm_theta_rad{jj}=Bpm_fem.rad(:,jj)';
    Bpm_theta_tan{jj}=Bpm_fem.tan(:,jj)';
end
[x,y]=ndgrid(Basic_I,Basic_Time);

I(1:m,1:360)={x};
T(1:m,1:360)={y};
Tpm(1:360)={Basic_Time'};
Method(1:m,1:360)={'spline'};
Barm_fun.rad=cellfun(@griddedInterpolant,I,T,Barm_theta_rad,Method,'UniformOutput',false);
Barm_fun.tan=cellfun(@griddedInterpolant,I,T,Barm_theta_tan,Method,'UniformOutput',false);
Bpm_fun.rad=cellfun(@griddedInterpolant,Tpm,Bpm_theta_rad,Method(1,:),'UniformOutput',false);
Bpm_fun.tan=cellfun(@griddedInterpolant,Tpm,Bpm_theta_tan,Method(1,:),'UniformOutput',false);
% save('E:\OneDrive - i.b.school.nz\GitHub\vibration_for_PMSM\WorkData\Barm_fun.mat','Barm_fun')
% save('E:\OneDrive - i.b.school.nz\GitHub\vibration_for_PMSM\WorkData\Bpm_fun.mat','Bpm_fun')