function [theta_dot]=heat_equation(theta_0,t)
%
%
%
%
global theta;
global w_ip1;
n=length(theta_0);
%
%
%
del_theta=theta_0-theta';
%
[diss]=dissipation(del_theta);
[advection]=udcdx(theta_0)-wdthetadz(theta_0);
%
theta_dot=advection+diss;
%
endfunction
