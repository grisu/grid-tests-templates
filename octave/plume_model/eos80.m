function spvol=eos80(p,t,s)
% function spvol=eos80(p,t,s)
% 
% specific volume of sea-water
% equation of state for seawater proposed by jpots 1980
% references
% millero et al 1980, deep-sea res.,27a,255-264
% jpots ninth report 1978,tenth report 1980
% units:
%       pressure        p        decibars
%       temperature     t        deg celsius (ipts-68)
%       salinity        s        nsu (ipss-78)
%       spec. vol.      spvol    cm**3/g
% check value: spvol = 9.435561e-1 cm**3/g for s = 40 nsu,
% t = 40 deg c, p = 10000 dbars.
%
% r. schlitzer  (5/18/89)
%%same numbers as eos80.m written by cw
%% slightly different logic
n=length(p); if n<=1, spvol=1; else, spvol=ones(size(p)); end
sig=sigma(p,t,s); spvol=spvol./(1+sig/1000);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
