function y=fun_w_pm(x,z,F,a,b,gprime,Rp2,theta2)

w=x(1);
s=sqrt((w-b)/(w-a)); %auxilliary quantity
zI=F(s,b,gprime,Rp2,theta2);
y=zI-z;