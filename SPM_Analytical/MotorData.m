clear;clc
%% Solution define
    Nlambda=75; %Number of Fourier coefficients in the relative air gap
                %permeance distribution (max. 128)                
    NB=90; %Number of Fourier coefficients in the flux density distribution
    N=150; %number of evaluation points (always use an even number!)
    mm=1e-03; %% unit:mm
    mu0=4*pi*1e-7;
%% Motor parameters define
    Qs=12; %number of slots
    p=5; %number of poles
    n=1500; %Rated speed [r/min]
    m=3;
    f=p*n/60;
    t=linspace(0,1/f,60);
    %% Coil pitch
    q=Qs/(2*m*p);
    if q==1
        yc=Qs/(2*p);
    elseif mod(q,1)~=0
        if Qs/(2*p)<1
            yc=1;
        else
            yc=floor(Qs/(2*p));
        end
    else
        yc=round(0.8*Qs/(2*p));
    end   
 %___________________________________________________________________________________
    %% Stator parameters
    Do=124*mm; %stator outer dimater
    Ds=85*mm; %stator inner dimater
    la=36*mm; %core length
    g=0.7*mm; %air gap size
    bo=2.8*mm; %slot opening width
    do=1*mm; %slot opening depth
    dslot=11.8*mm; %slot depth
    %% PM parameters
    alpha_p=0.88; %relative magnet angular span
    hm=3.2*mm; %magnet thickness
    Br=1.12; %magnet remanence
    Hc=841.8e3; %magnet coercivity
    mur=1.05; %magnet relative permeability
    Mtype='P'; %Type of magnetization
    delta_d=21.0*mm;
    %% Devied parameters
    Rs=Ds*0.5; %stator inner radius
	Rm=Rs-g; %Magnet radius
	Rr=Rs-g-hm; %Rotor radius
	R=Rs-g*0.5; % calculated radius
	
	RmRs=Rm/Rs;
	RrRm=Rr/Rm;
	RrRs=Rr/Rs;
	RRs=R/Rs;
	RmR=Rm/R;
%% coil parameters
    Ns=42; % turns per coil
    a=1; % number of parallel path
    I=8.49; % peak current
%% conformal mapping
    [lambda,lambda_r,lambda_t,theta_l]=conformal_mapping(N,R,Rr,Rs,Qs,bo,Nlambda);
%% calculate pm flux density
%     [Brn,Bthn,Brn1,Btn1,Bpm_r,Bpms_r,Rmj,ang,theta]=PM_flux_density_BreadLoaf_cal(NB,Mtype,Br,p,alpha_p,mu0,mur,R,Rm,hm,Rs,Rr,lambda_r,lambda_t,f,t,delta_d);
    [Bpm_r,Bpm_t,Bpms,Bpms_r,Bpms_t,theta_b,Brn,ang]=PM_flux_density_cal(NB,Mtype,Br,p,alpha_p,mu0,mur,R,Rm,Rs,Rr,lambda_r,lambda_t,f,t);
%% calculate armature flux density
    [Barm_r,Barm_t,Barms_r,Barms_t,theta_arm]=Armature_flux_density_cal(mu0,Qs,p,Rs,Rm,R,Rr,bo,n,f,t,Ns,a,I,lambda_r,lambda_t);
%% calculate air-gap flux density
    [Bg_r,Bg_t,theta_g]=Air_gap_flux_density(Bpms_r,Bpms_t,Barms_r,Barms_t,lambda_r,lambda_t);
%% Plot radial and tangential permeance
    Fig_plot(lambda,lambda_r,lambda_t,theta_l,Bpm_r,Bpm_t,Bpms_r,Bpms_t,theta_b,Barm_r,Barm_t,Barms_r,Barms_t,theta_arm,Bg_r,Bg_t,theta_g);