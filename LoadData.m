load('Barm_fun.mat');
load('Bpm_fun.mat');
load('Bg_load.mat');
load('Bg_noload.mat');
load('Bg_load_HF.mat');
load('ForceJmagLoad.mat');
load('ForceJmagNoload.mat');
load('ForceJmagLoadHF.mat');
load('TestLoad.mat');
load('TestNoload.mat');
load('FreqResTooth.mat');
load('FreqResWave.mat');
load('FreqResWaveFix.mat');
load('I_harm.mat');

mm=1e-3;
mu0=4*pi*10^-7;% permeability in vacuum
Basic_speed=1000;
%% Data Input
%======================= Geometry Data,Simulation Data =============
Qs=36;% slot number
p=3;% pole pairs
L=85*mm;% stack legnth
Ris=40.9*mm;% stator inner radius
SlotOpen=2.8*mm;% slot opening
alpha_b0=SlotOpen/Ris;% cofficient of slot opening
Nt=gcd(Qs,p);% number of motor units
%======================= Coil information ==========================
yq=6;m=6;
Ns=14;% number of turns in series
Nlayer=2; % number of layers
ap=1; % number of parallel path
Nc=Ns*Nlayer; % number of conductors
n3ph=2; % number of three phase winding
Beta=30*pi/180;% phase belt degree
alphaS=30*pi/180;% phase shift between the two sets of three phase winding
% ====================== Structure parameters ======================
Mode=[0,2,4,6];% number of model in calculation
ForceNum=[6,4,2,0,-2,-4,-6];% spatial order of force in calculation
f_modal=[9100,1867.25,6277.8,11254];% modal frequency[0,2,4,6]
damp=[5.63,1.16,3.88,6.96]*1e-02;% damping ratio
StaDef.rad=[1.4056e-9,4.2437e-8,2.3e-9,1.0034e-9]; %[0,2,4,6],Static Deformation Function,Unit:m
StaDef.tan=[6.6104e-11,3.96e-8,3.0225e-9,1.6588e-9]*(-1i);
StaDef.tq=[4.0914e-8,1.088e-6,1.3972e-7,8.8213e-8]*(1i);