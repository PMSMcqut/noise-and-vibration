function [Bg_r,Bg_t,theta_g]=Air_gap_flux_density(Bpms_r,Bpms_t,Barms_r,Barms_t,lambda_r,lambda_t)
theta_g=linspace(0-pi/2,2*pi-pi/2,360);
Bg_r=Bpms_r+Barms_r;
Bg_t=Bpms_t+Barms_t;
end