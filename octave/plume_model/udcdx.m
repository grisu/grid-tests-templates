function [cdot]=udcdx(c)
%
%
global u_ip1
global w_ip1
global distance
n=length(c);
c=u_ip1.*c;
%
% Horizontal advection term
%
cdot(1)=(c(2)-c(1))./(distance(2)-distance(1));
cdot(2:n-1)=(c(3:n)-c(2:n-1))./(distance(3:n)-distance(2:n-1));
cdot(n)=(c(n)-c(n-1))./(distance(n)-distance(n-1));
%
%
%
%
% Average back onto the real grid points
%
cdot(1)=cdot(1);
cdot(2:n)=(cdot(1:n-1)+cdot(2:n))/2;
%
% Vertical advection term
%

w
endfunction
