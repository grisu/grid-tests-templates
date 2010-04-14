function [cdot]=wdthetadz(c)
%
%
global w_ip1;
global thickness;
global theta;
dx=100*1000;
n=length(c);
%
%
%
cdot=w_ip1'.*(theta'-c)/thickness;
%
endfunction
