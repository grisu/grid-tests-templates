function [a]=alpha(s, theta, p)
% function [a]=alpha(s, theta, p)
%
% A function to calculate the thermal expansion coefficient as 
% defined by T.J. McDougall
%
% Input
% s     - m*n matrix of salinity (psu)
% theta - m*n matrix of potential temperature (C)
% p     - m*n matrix of pressure in db (db)
%
% output
% a  - m*n matrix of alpha (C.^-1)
% reference: JPO vol 17 pages 1950-1964, Neutral Surfaces, T McDougall
% Author: N.L. Bindoff
	a=adb(s,theta,p).*beta(s,theta,p);

