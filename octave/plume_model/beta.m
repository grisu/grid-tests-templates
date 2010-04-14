function [b]=beta(s, theta, p)
% function [b]=beta(s, theta, p)
%
% The saline contraction coefficient as defined by T.J. McDougall
%
% Input
% s     - m*n matrix of salinity (psu)
% theta - m*n matrix of potential temperature (C)
% p     - m*n matrix of pressure in db (db)
%
% output
% b  - m*n matirx of beta (psu.^-1)
% check value: 0.72088e-3 psu.^-1 at s=40.0 psu, theta = 10.0, p=4000db
% reference: JPO vol 17 pages 1950-1964, Neutral Surfaces, T McDougall
% Author: N.L. Bindoff
%
%
	c1=fliplr([ 0.785567e-3, -0.301985e-5 ...
	     0.555579e-7, -0.415613e-9]);
	c2=fliplr([ -0.356603e-6, 0.788212e-8]);
	c3=fliplr([0.0 0.408195e-10, -0.602281e-15]);
	c4=[0.515032e-8];
	c5=fliplr([-0.121555e-7, 0.192867e-9, -0.213127e-11]);
        c6=fliplr([0.176621e-12 -0.175379e-14]);
	c7=[0.121551e-17];
%
% Now calaculate the thermal expansion saline contraction ratio adb
%
	[m,n]=size(s);
	sm35=s-35*ones(m,n);
	b = polyval(c1,theta) + sm35.*(polyval(c2,theta) + ...
	    polyval(c3,p)) + c4*(sm35.^2) + ...
	    p.*polyval(c5,theta) + (p.^2).*polyval(c6,theta) ...
            +c7*( p.^3);
