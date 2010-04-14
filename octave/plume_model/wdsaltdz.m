function [cdot]=wdsaltdz(c)
%
%
global w_ip1
global thickness
global salt
n=length(c);
%
%
%
cdot=w_ip1'.*(salt'-c)/thickness;
%
endfunction
