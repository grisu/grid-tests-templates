function [w]=solve_w(u,distance,thickness)
%
% Input
%
% u n*1 vector of downslope velocities
% 
% Output
% w n*1 vertical velocity
%
% equation 
% w=-h*(u_i+1-u_i)./(d_i+1-d_i)
%
%
%global distance;
%global thickness;
n=length(u);
%
%
%
jp1=[2,3:n,n];
jm1=[1,1:n-2,n-1];
%jp1=[1:n];
%jm1=[1:n];
%w_tmp=(u(jp1)-u(jm1))./(distance(jp1)-distance(jm1));
w_tmp(1:n-1)=(u(2:n)-u(1:n-1))./(distance(2:n)-distance(1:n-1));
w_tmp(n)=(u(n)-u(n-1))./(distance(n)-distance(n-1));
%
% scale the vertical velocity by the thickness of the layer
%
w=-thickness*w_tmp;
%
% Average back onto the real grid points
%
%w(1)=w_tmp(1);
%w(2:n)=(w_tmp(1:n-1)+w_tmp(2:n))/2;
%
%
end
