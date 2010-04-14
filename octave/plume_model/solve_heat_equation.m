function [dthetadt]=solve_heat_equation(theta_0,theta,u,w_ip1,distance,thickness,entrainment)
%
% 
%
%
%
%
%
%global theta;
%global w_ip1;
n=length(theta_0);
%
% Estimate midpoint field values
% 
u_m=(u(2:n)+u(1:n-1))/2;
u_m(n)=u_m(n-1);
%
theta_m=(theta_0(2:n)+theta_0(1:n-1))/2;
theta_m(n)=theta_m(n-1);
%
tmp1=u_m.*theta_m;
tmp2(1:n-1)=(tmp1(2:n)-tmp1(1:n-1))./(distance(2:n)-distance(1:n-1));
tmp2(n)=(tmp1(n)-tmp1(n-1))./(distance(n)-distance(n-1));
%
%
tmp3=w_ip1.*(theta_0-theta)/thickness;
%
%
tmp4=entrainment*(theta_0-theta)/thickness;
%
%
dthetadt=tmp2+tmp3+tmp4;
%
%plot(distance,tmp2)
%hold on
%plot(distance,tmp3)
%plot(distance,tmp4)
%plot(distance,dhetadt)
%pause
%hold off
%
%
endfunction

