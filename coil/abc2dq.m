function [Xd,Xq]= abc2dq (theta_elec_rad,Xa,Xb,Xc)
 Xd=2/3*(Xa.*cos(theta_elec_rad)+Xb.*cos(theta_elec_rad-2*pi/3)+Xc.*cos(theta_elec_rad+2*pi/3));
 Xq=-2/3*(Xa.*sin(theta_elec_rad)+Xb.*sin(theta_elec_rad-2*pi/3)+Xc.*sin(theta_elec_rad+2*pi/3));
end