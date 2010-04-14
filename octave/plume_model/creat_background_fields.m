%
%
%
% Create the background fields for the plume model
%
% N.L. Bindoff
% Date: 6/September/2002
% 
% Use an analytic backround field for testing purposes
%
distance=1000*[0:0.1:100];        % 100km in metres
pressure=(100*ones(length(distance),1)+3000*exp(-fliplr(distance).^2/30));

inc=(-0.5 - -1.8)/length(distance);

theta=[-1.8:inc:-0.5];

dec=(34.6 - 34.5)/length(distance);

salt=[34.5:dec:34.6];

deltay=distance(2)-distance(1);

slope=(pressure(2:length(distance))-pressure(1:length(distance)))/deltay

%
%pressure=
%distance=
%theta=
%salt=
%slope=

save background_fields distance pressure theta salt slope

