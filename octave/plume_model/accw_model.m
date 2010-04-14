function [cdot]=accw_model(c,t)
%
%
%
%
n=length(c);
%
%
[forcing]=forcing_atmosphere(c,t)';
[convection]=convection_model(c)';
[diss]=dissipation(c);
[advection]=udcdx(c);
%keyboard
%
cdot=advection+diss+convection.*forcing;
%cdot=advection+diss;
%
endfunction
