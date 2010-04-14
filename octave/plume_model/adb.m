	function [aonb]= adb(s, theta, p)
%
% Input
% s     - m*n matrix of salinity (psu)
% theta - m*n matrix of potential temperature (C)
% p     - m*n matrix of pressure in db (db)
%
% output
% aonb  - m*n matirx of alpha/beta (psu.C^-1)
% check value: 0.34763 psu.C-1 at s=40.0 psu, theta = 10.0, p=4000db
% reference: JPO vol 17 pages 1950-1964, Neutral Surfaces, T McDougall
%
% Authour: N.L. Bindoff
%
%

	 c1=fliplr([ 0.665157e-1, 0.170907e-1, ...
	    -0.203814e-3, 0.298357e-5, ...
            -0.255019e-7]);
         c2=fliplr([ 0.378110e-2, ...
            -0.846960e-4]);
         c2a=fliplr([0.0 -0.164759e-6, ...
            -0.251520e-11]);
         c3=[-0.678662e-5];
         c4=fliplr([+0.380374e-4, -0.933746e-6, ...
            +0.791325e-8]);
         c5=[0.512857e-12];
         c6=[-0.302285e-13];
%
% Now calaculate the thermal expansion saline contraction ratio adb
%
        [m,n]=size(s);
        sm35=s-35.0*ones(m,n);
        aonb = polyval(c1,theta) + sm35.*(polyval(c2,theta)...
              +polyval(c2a,p)) ...
              + sm35.^2*c3 + p.*polyval(c4,theta) ...
              + c5*(p.^2).*(theta.^2) + c6*p.^3;

