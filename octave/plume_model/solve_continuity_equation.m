function [thickness_ip1]=solve_continuity_equation(thickness_i,U_transport,w_e,distance, time_step)
%
% 
%
%
%
%
%
n=length(thickness_i);
%
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
tmp1=(U_transport(jp1)-U_transport(jm1))./(distance(jp1)-distance(jm1));
tmp3=w_e;
dthicknessdt=-tmp1-tmp3;          %remove effects of vertical velocity
%
thickness_tmp=time_step*dthicknessdt;
%
% half time step variables
%
thickness_tmp=thickness_tmp/2+(thickness_i(indexj)+thickness_i(indexjp1))/2;
U_transport_m=(U_transport(indexj)+U_transport(indexjp1))/2;
w_e_m=(w_e(indexj)+w_e(indexjp1))/2;
%
tmp1_m=(U_transport_m(jp1)-U_transport_m(jm1))./(distance(jp1)-distance(jm1));
dthicknessdt_m=-tmp1-tmp3;          %remove effects of vertical velocity
%
thickness_ip1= time_step*dthicknessdt_m+thickness_i;
%
%plot(distance,u/20000)
%hold on
%plot(distance,tmp1)
%hold on
%plot(distance,tmp3)
%plot(distance,tmp4)
%pause
%hold off
%
%
end

