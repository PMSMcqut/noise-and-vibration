function Fig_plot(lambda,lambda_r,lambda_t,theta_l,Bpm_r,Bpm_t,Bpms_r,Bpms_t,theta_b,Barm_r,Barm_t,Barms_r,Barms_t,theta_arm,Bg_r,Bg_t,theta_g)
Xmin=-90;Xmax=270;
%% Plot radial and tangential permeance
      figure(1);
      set(0,'defaultfigurecolor','w')
      s(1)=subplot(2,2,1);
      plot(real(lambda),'Linewidth',2);grid
      title(s(1),'\lambda_r in one slot pitch')
%       xlabel('\theta (mech. degrees)')
      ylabel('\lambda_r')
      s(2)=subplot(2,2,2);
      plot(imag(lambda),'Linewidth',2);grid
      title(s(2),'\lambda_t in one slot pitch')
%       xlabel('\theta (mech. degrees)')
      ylabel('\lambda_t')
      s(3)=subplot(2,2,3);
      plot(theta_l*180/pi,lambda_r,'Linewidth',2);grid
      title(s(3),'\lambda_r in whole stator')
      xlabel('\theta (mech. degrees)')
      ylabel('\lambda_r')
      set(gca,'xlim',[Xmin Xmax]);
      s(4)=subplot(2,2,4);
      plot(theta_l*180/pi,lambda_t,'Linewidth',2);grid
      title(s(4),'\lambda_t in whole stator')
      xlabel('\theta (mech. degrees)')
      ylabel('\lambda_b')
      set(gca,'xlim',[Xmin Xmax]);
%% Plot radial and tangential pm flux density
     figure(2);
     set(0,'defaultfigurecolor','w')
     s(1)=subplot(2,2,1);
     plot(theta_b*180/pi,Bpm_r(:,1),'Linewidth',2);grid
     title(s(1),'PM flux density slotless(radial)')
%      xlabel('Angular position \theta (mech. degrees)')
     ylabel('B_{pmr} (T)')
     set(gca,'xlim',[Xmin Xmax]);
     s(2)=subplot(2,2,2);
     plot(theta_b*180/pi,Bpm_t(:,1),'Linewidth',2);grid
     title(s(2),'PM flux density slotless(tangential)')
%      xlabel('Angular position \theta (mech. degrees)')
     ylabel('B_{pm\theta} (T)')
     set(gca,'xlim',[Xmin Xmax]);
     s(3)=subplot(2,2,3);
     plot(theta_b*180/pi,Bpms_r(:,1),'Linewidth',2);grid
     title(s(3),'PM flux density with slot(radial)')
     xlabel('\theta (mech. degrees)')
     ylabel('B_{pmsr} (T)')
     set(gca,'xlim',[Xmin Xmax]);
     s(4)=subplot(2,2,4);
     plot(theta_b*180/pi,Bpms_t(:,1),'Linewidth',2);grid
     title(s(4),'PM flux density with slot(tangential)')
     xlabel('\theta (mech. degrees)')
     ylabel('B_{pms\theta} (T)')
     set(gca,'xlim',[Xmin Xmax]);
%% Plot radial and tangential armature flux density
     figure(3)
     set(0,'defaultfigurecolor','w')
     s(1)=subplot(2,2,1);
     plot(theta_arm*180/pi,Barm_r(:,1),'Linewidth',2);grid
     title(s(1),'Armature flux density slotless(radial)')
%      xlabel('Angular position \theta (mech. degrees)')
     ylabel('B_{armr} (T)')
     set(gca,'xlim',[0+15 360+15]);
     s(2)=subplot(2,2,2);
     plot(theta_arm*180/pi,Barm_t(:,1),'Linewidth',2);grid
     title(s(2),'Armature flux density slotless(tangential)')
%      xlabel('Angular position \theta (mech. degrees)')
     ylabel('B_{arm\theta} (T)')
     set(gca,'xlim',[0+15 360+15]);
     s(3)=subplot(2,2,3);
     plot(theta_arm*180/pi,Barms_r(:,1),'Linewidth',2);grid
     title(s(3),'Armature flux density with slot(radial)')
     xlabel('\theta (mech. degrees)')
     ylabel('B_{armsr} (T)')
     set(gca,'xlim',[0+15 360+15]);
     s(4)=subplot(2,2,4);
     plot(theta_arm*180/pi,Barms_t(:,1),'Linewidth',2);grid
     title(s(4),'Armature flux density with slot(tangential)')
     xlabel('\theta (mech. degrees)')
     ylabel('B_{arms\theta} (T)')
     set(gca,'xlim',[0+15 360+15]);
%% Plot air-gap flux density
     figure(4)
     set(0,'defaultfigurecolor','w')
     s(1)=subplot(2,1,1);
     plot(theta_g*180/pi,Bg_r(:,1),'Linewidth',2);grid
     title(s(1),'Air-gap flux density(radial)')
%      xlabel('Angular position \theta (mech. degrees)')
     ylabel('B_{gr} (T)')
     set(gca,'xlim',[Xmin Xmax]);
     s(2)=subplot(2,1,2);
     plot(theta_g*180/pi,Bg_t(:,1),'Linewidth',2);grid
     title(s(2),'Air-gap flux density (tangential)')
     xlabel('\theta (mech. degrees)')
     ylabel('B_{g\theta} (T)')
     set(gca,'xlim',[Xmin Xmax]);
end