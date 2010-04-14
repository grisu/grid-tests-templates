function [theta_dot]=salt_equation(theta_0,t)
%
%
%
%
global salt;
n=length(theta_0);
%
%
%
%load background_fields
del_theta=theta_0-salt';
[diss]=dissipation(del_theta);
[advection]=udcdx(theta_0)-wdsaltdz(theta_0);
%
theta_dot=advection+diss;
%
endfunction
