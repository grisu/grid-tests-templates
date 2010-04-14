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
%
Length_scale=50*1000;             % 50km
%distance=250*[0:01:800];        % 200km in metres
distance=250*[0:04:800];        % 800km in metres
pressure=[100*ones(1,25), 3100*ones(1,length(distance)-25)-3000*exp(-(distance(1:176)/Length_scale).^2)];
%pressure=[(100*ones(1,25),3100*ones(1,length(distance)-100)-3000*exp(-((distance(1:176))/length_scale).^2))];
depth=-pressure;

inc=(-0.5 - -1.8)/(length(distance)-1);

%theta=[-1.8:inc:-0.5];

theta=[-1.8*ones(1,25), -0.5*ones(1,length(distance)-25)-(1.8-0.5)*exp(-(distance(1:176)/Length_scale).^2)];

salt=[34.4*ones(1,25), 34.65*ones(1,length(distance)-25)-(34.65-34.4)*exp(-(distance(1:176)/Length_scale).^2)];


%dec= (34.6 - 34.5)/(length(distance)-1);

%salt=[34.5:dec:34.6];

deltay=distance(2)-distance(1);
%
%
%
%
%
slope=[0,(pressure(2:length(distance))-pressure(1:length(distance)-1))];
slope=slope/deltay;

%
%pressure=
%distance=
%theta=
%salt=
%slope=

save background_fields.mat distance pressure depth theta salt slope

