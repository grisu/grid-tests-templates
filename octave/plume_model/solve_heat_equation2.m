function [dthetadt]=solve_heat_equation2(theta_0,theta,u,w_ip1,distance,thickness)
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
%
jp1=[2:n,n];
jm1=[1:n-1,n-1];
%
%
tmp1=(u.*theta_0(jp1)-u.*theta_0(jm1))./(distance(jp1)-distance(jm1));
%tmp1=(u(jp1).*theta_0(jp1)-u(jm1).*theta_0(jm1))./(distance(jp1)-distance(jm1));
%
tmp3=w_ip1.*(theta-theta_0)./thickness;
%tmp3=-w_ip1.*theta/thickness;
%
%
dthetadt=tmp1+tmp3;          %remove effects of vertical velocity
%
%plot(distance,u/20000)
%hold on
%plot(distance,tmp1)
%hold on
%plot(distance,tmp3)
%plot(distance,tmp4)
%plot(distance,dthetadt)
%pause
%hold off
%
%
end

