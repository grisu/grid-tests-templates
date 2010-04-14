function sig=sigma_thermobaric(pressure,theta,salinity)
% function sig=sigma(p,t,s)
%
% Calculates thermobaric density
%
% theta    potential density
% salinity salinity (ipss-78)
% pressure decibars
%
%
[m,n]=size(salinity);
dens_ref=1000+sigma(0,-1,34.7);
sig=dens_ref*(beta(salinity,theta,pressure).*salinity-alpha(salinity,theta,pressure).*theta);
%
