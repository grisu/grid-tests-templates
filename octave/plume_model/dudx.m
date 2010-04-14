function [cdot]=dudx(c)
%
%
global distance;
n=length(c);
%
%
%
cdot(1)=(c(2)-c(1))/1;
cdot(2:n-1)=(c(3:n)-c(1:n-2))/2;
cdot(n)=(c(n)-c(n-1))/1;
cdot=-cdot/(distance(2)-distance(1));
%
%plot(distance,cdot)
endfunction
