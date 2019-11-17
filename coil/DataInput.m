% Winding Calculation for Multi-Phase Eletrical Machines
% Copyright (c) 2017-2020
% School of Electrical and Electronics of Engineering
% Huazhong University of Science and Technology
% All Rights Reserved
%
%              Programmer:Lu,Yang yanglu_hust@sina.com
%              Version:1.0
%              Last modified:22/08/2018
%% input initial parameter
clc;clear;
close all
Qs=12;p=5;yq=1;m=3;
n3ph=1; % number of three phase winding
Beta=60*pi/180;% phase belt degree
alphaS=30*pi/180;% phase shift between the two sets of three phase winding
n=1000;
f=p*n/60;T=1/f;
t=linspace(0,T,60);
I=1;
% winding factor parameter
alpha_b0=2.8/42.5;
v=[1:50];
Slot_Opening_factor=0;
harm=linspace(0,30,30);
%% Current
for j=1:n3ph
    for i=1:m/n3ph
        Current(i+m/n3ph*(j-1),:)=I*cos((2*pi*f*t-2*pi/3*(i-1)-pi/6*(j-1)));
    end
end
%% Winding Arrangement
[Winding,Slot]=WindingArrange(Qs,p,yq,m,n3ph,Beta,alphaS);
%% Slot Matrix
[SlotMatrix]=SlotMatrix(Qs,m,Winding);
%% MMF calculation
[theta,MMF,MMF_pu,FW_m,VabcPhase]=MMF(Qs,SlotMatrix,Current,t);
%% Winding Factor
[kwv,kqv,kyv,ksv]=WinFactor(Qs,yq,n3ph,m,Slot,v,alpha_b0,Slot_Opening_factor);
%% Slot Star
SlotStar(Qs,p,m,Winding,Beta);
%% Figure Plot
FigPlot(Qs,m,theta,MMF,harm,MMF_pu,kwv,p);
%% Coil Plot
CoilPlot(Qs,Winding,m);
