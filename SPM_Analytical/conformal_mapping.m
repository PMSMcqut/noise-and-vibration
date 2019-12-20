function [lambda,lambda_r,lambda_t,theta_l]=conformal_mapping(N,R,Rr,Rs,Qs,bo,Nlambda)
%% CONFORMAL MAPPING OF THE SLOT STRUCTURE
     %% Polar coordinates of the characteristic points on the slot outline
	Rp1=Rr;
	Rp2=Rs;
	Rp3=Rs;
	Rp4=Rs;
	thetas=2*pi/Qs; %slot pitch in rad
	alphao=2*asin(0.5*bo/Rs); %slot opening in rad
	theta1=thetas/2-alphao/2;
	theta2=theta1+alphao;
    clear j
    %% Coefficients of the conformal mapping function
	boprime=theta2-theta1;
	gprime=log(Rp2/Rp1);
	bCM=(boprime/2/gprime+sqrt((boprime/2/gprime)^2+1))^2;
	aCM=1/bCM;
    
    %% CALCULATE COMPLEX RELATIVE AIR GAP PERMEANCE
	clear z_real z_imag
% 	z_imag=j*[0:thetas/N:thetas];
    z_imag=j*linspace(0,thetas,150);
	z_real(1:length(z_imag))=log(R);
	z=z_real+z_imag; %Coordinates of the points in the Z plane
	s=exp(z);
    %% Define conformal mapping function
	FCM=inline('j*gprime/pi*(log((1+s)/(1-s))-log((b+s)/(b-s))-2*(b-1)/sqrt(b)*atan(s/sqrt(b)))+log(Rp2)+j*theta2',...
        's','b','gprime','Rp2','theta2');

    %% START OPTIMIZATION
	w0=[0.05*aCM]; %initial values
	options=optimset('Display','off','TolFun',1e-24,'TolX',1e-18,'LargeScale','on','MaxFunEvals',5000);   % Option to display output
	for i=1:length(z)
        [w(i),resnorm,residual,exitflag]=lsqnonlin(@fun_w_pm,w0,[],[],options,z(i),FCM,aCM,bCM,gprime,Rp2,theta2);  % Call optimizer
        k(i)=exp(j*gprime/pi*log(w(i))+log(Rp2)+j*thetas/2);
        lambda(i)=k(i)*(w(i)-1)/(w(i)-aCM)^(1/2)/(w(i)-bCM)^(1/2)/s(i);
        fprintf(1,'Iteration: %d,   dt/dz: %f\n',i,lambda(i));
        w0=w(i);
    end
%% END OPTIMIZATION
	%if mod(yc,2)==1
     %   lambda=[lambda conj(lambda(N/2:-1:2))];
	%else
        lambda=[conj(lambda(N/2+1:-1:1)) lambda(2:N/2)];
    %end
%% FFT of the relative air gap permeance distribution,radial and tangential components calculation
	real_fft=fft(real(lambda),N);
	imag_fft=fft(imag(lambda),N);
	
	lambda0=real_fft(1)/N;
	m=1:Nlambda;
	lambda_am=2*real(real_fft(m+1))/N;
	lambda_bm=-2*imag(imag_fft(m+1))/N;
    
%   	theta=[0:thetas/N:2*pi/p]*p;
    theta_l=linspace(0-pi/2,2*pi-pi/2,360);
	ang=Qs*theta_l'*m;
	lambda_r=lambda0+cos(ang)*lambda_am';
	lambda_t=sin(ang)*lambda_bm';
end