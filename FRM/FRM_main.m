clear;clc;
load('Basic_Fun_FP.mat');% conductor:Nc, current in one conductor: Basic_I, two slot
load('Bpm_fem.mat');
% load('Barm_fem.mat');
% load('Bg_fem.mat');
Qs=36;p=3;yq=6;m=6;
Nt=gcd(Qs,p); % number of unit motor
Ns=14;% number of turns in series
Nlayer=2; % number of layers
ap=1; % number of parallel path
Nc=Ns*Nlayer; % number of conductors
n3ph=2; % number of three phase winding
Beta=30*pi/180;% phase belt degree
alphaS=30*pi/180;% phase shift between the two sets of three phase winding
rpm=1000;
f0=p*rpm/60;
T=1/f0;
Ipeak=[7.07,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]; % peak value of phase current
gamma=[21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
Basic_I=0.5:0.5:15; % equivalent current of one conductor for basic function
time=(0:T/200:T-T/200)';
% Winding Arrangement and Slot Matrix 
[Winding,Slot]=WindingArrange(Qs,p,yq,m,n3ph,Beta,alphaS);
[SlotMatrix]=SlotMatrix(Qs,m,Winding);
% Calcualtion the air-gap flux density by field reconstruction method
for t=1%:length(time)
[Iph(t,:),Islot(t,:),Barm_frm_t,Bg_frm_t,Bpm_fem_t]=FRM_fun(Qs,p,m,n3ph,Nt,ap,f0,Ipeak,gamma,time(t),SlotMatrix,Basic_Fun,Basic_I,Bpm_fem);
% [Iph(t,:),Islot(t,:),Barm_frm_t,Bg_frm_t,Bpm_fem_t]=FRM_fun_mex(Qs,p,m,n3ph,Nt,ap,f0,rpm,Ipeak,gamma,time(t),SlotMatrix,Basic_Fun,Basic_I,Bpm_fem);
Barm_frm.rad(t,:)=Barm_frm_t.rad;
Barm_frm.tan(t,:)=Barm_frm_t.tan;
Bg_frm.rad(t,:)=Bg_frm_t.rad;
Bg_frm.tan(t,:)=Bg_frm_t.tan;
end
Bg_frm.rad(length(time)+1,:)=Bg_frm.rad(1,:);
Bg_frm.tan(length(time)+1,:)=Bg_frm.tan(1,:);
Bg_frm.rad(:,size(Bg_frm.rad,2)+1)=Bg_frm.rad(:,1);
Bg_frm.tan(:,size(Bg_frm.tan,2)+1)=Bg_frm.tan(:,1);
