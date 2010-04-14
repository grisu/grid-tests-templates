function [theta_ip1]=solve_heat_plume(theta_i,theta,u,w_ip1,distance,thickness,time_step)
%
% 
%
%
%
%
%
%global theta;
%global w_ip1;
n=length(theta_i);
%
%
indexjp1=[2:n,n-1];
indexj=[1:n-1,n];
indexjm1=[2,1:n-2,n-1];
%
%
jp1=[2:n,n];
jm1=[1:n-1,n-1];
%
%
%
tmp3=zeros(1,n);
tmp3_m=tmp3;
index_zeros=find(thickness<0.1);
index_good=find(thickness>=0.1);
if ~isempty(index_zeros),
		   theta_i(index_zeros)=theta(index_zeros);
                   tmp3(index_zeros)=zeros(1,length(index_zeros));
end
tmp3(index_good)=w_ip1(index_good).*(theta(index_good)-theta_i(index_good))./thickness(index_good);
%
tmp1=(u.*theta_i(jp1)-u.*theta_i(jm1))./(distance(jp1)-distance(jm1));
%
%
%tmp3=-w_ip1.*theta/thickness;
%
%
dthetadt=-(tmp1+tmp3);          %remove effects of vertical velocity
theta_tmp=time_step*dthetadt;
%
% half time step variables
%
theta_tmp=theta_tmp/2+(theta_i(indexj)+theta_i(indexjp1))/2;
theta_m=(theta(indexj)+theta(indexjp1))/2;
%u_m=(u_ip1(indexj)+u_ip1(indexjp1))/2;
%w_m=(w_ip1(indexj)+w_ip1(indexjp1))/2;

tmp1_m=(u.*theta_i(jp1)-u.*theta_i(jm1))./(distance(jp1)-distance(jm1));
%
%
if ~isempty(index_zeros),
		   theta_tmp(index_zeros)=theta(index_zeros);
                   tmp3_m(index_zeros)=zeros(1,length(index_zeros));
end
tmp3_m(index_good)=w_ip1(index_good).*(theta_m(index_good)-theta_tmp(index_good))./thickness(index_good);

dthetadt_m=-(tmp1_m+tmp3_m);

theta_ip1= time_step*dthetadt_m+theta_i;

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

