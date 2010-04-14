%
%
%
% 
%
%
%
clear
hold off
%
%
%entrainment=0.0 % Entrainment parameter
entrainment_timescale =0.01 % hours too much entrainment
entrainment_timescale =0.03 % hours 
entrainment_timescale =10000.0 % hours the density of background now correct 
entrainment_timescale =20000.0 % hours the density of background now correct 
entrainment_timescale =40000.0 % hours the density of background now correct 
entrainment_timescale =2.0 % hours the density of background now correct 
entrainment_timescale =0.01 % hours the density of background now correct 
entrainment_timescale =0.1 % hours the density of background now correct 
%entrainment_timescale =1.0 % hours the density of background now correct 
%entrainment_timescale =0.5 % hours the density of background now correct 
%
%
%
entrainment=1/(entrainment_timescale*3600)    % seconds
%entrainment=0.0    % seconds
factor=1.0
factor=0.0         % keeps speed dependent mixing out
bottom_friction=0.001  % Bottom friction
bottom_friction=0.004  % Bottom friction
thickness=100 % Bottom layer thickness
time_step=0.25 % time step in seconds
time_step=0.50 % time step in seconds
time_step=1.0 % time step in seconds
w_factor=1.0   % include vertical velocity (set to 1.0)
K_h=0.4
K_h=0.2 
K_h=0.1 
K_h=0.05
K_h=0.02
K_h=0.01
K_h=0.001
K_h=0.0025
K_h=0.0015
K_h=0.002
%
%
% scale controls the amplitude of temperature/salinity anomaly
scale=0.25        %experiment 7
scale=0.12        %experiment 7
scale=1.0
scale=0.1         %experiment 2 21 January 2003
%K_h=0.00
%
%
hours=48          % number of hours to integrate over
hours_timesteps=hours*3600/time_step   
%
%
plot_hours=1.0
plot_time_step=plot_hours*3600/time_step % number of timesteps per plot
%
% Initialise the background fields
%
load background_fields.mat
%
%pressure=0*pressure % experiment 6
%distance=
%theta=
%salt=
%slope=u_
%
% Setting memory requirements for output fields
% 
number_fields=hours/plot_hours
theta_field=NaN*zeros(number_fields,length(theta));
salt_field=theta_field;
delta_dens_field=theta_field;
u_field=theta_field;
w_field=theta_field;
time_field=NaN*zeros(number_fields,1);
%
% Calculate gravity and reference density
%
g_slope=-9.82*slope;
g=-9.82;
dens_ref=1000+sigma(0,-1,34.7);
%
%
% Initialise the fields
%
theta_i=theta;
salt_i=salt;
u_i=zeros(1,length(theta));
w_i=zeros(1,length(theta));
h_i=zeros(1,length(theta));
delta_dens_i=zeros(1,length(theta));
%
% Indices to j+1 and j-1 spatial points
% 
n=length(theta);
indexjp1=[2:n,n-1];
indexj=[1:n-1,n];
indexjm1=[2,1:n-2,n-1];
%
%
jp1=indexjp1;
j=indexj;
jm1=indexjm1;
%
% Inject jet at beginning of flow
%
n=length(theta);
     position=round(0.23*n);
     theta_anomaly=-scale*0.2*exp(-(([1:n]-position*ones(1,n))/5).^2);
     salt_anomaly=scale*0.2*exp(-(([1:n]-position*ones(1,n))/5).^2);
%     salt_anomaly=0.05*exp(-(([1:n]-position*ones(1,n))/5).^2);
theta_i=theta_i+theta_anomaly;
salt_i=salt_i+salt_anomaly;
%
%u_i(1)=0.01;
%
%
% Calculate the density outside the plume
%
%density_background=sigma(pressure,theta,salt);
density_background=sigma_thermobaric(pressure,theta,salt);
%
%
count=0
count_output=0
%
for i=1:hours_timesteps    %in time steps
%
% Calculate the density inside the plume
%
%density_ip1=sigma(pressure,theta_i,salt_i);
density_ip1=sigma_thermobaric(pressure,theta_i,salt_i);
%
% Calculate the density difference between ambience and layer
%
delta_dens_ip1=density_ip1-density_background;
%
% Test flow for positive buoyancy
%
% Calculate the downslope velocity
%
term1=thickness*g_slope.*delta_dens_ip1/dens_ref;
term2=g*thickness^2/(2*dens_ref).* ...
     (delta_dens_ip1(jp1)-delta_dens_ip1(jm1))./(distance([2,3:n,n])-distance([1,1:n-1]));
%u_squared=(-term1 -term2)/bottom_friction;
u_squared=(-term1)/bottom_friction;
%plot(distance,u_squared)
%hold on
%plot(distance,term1)
%plot(distance,term1)
%
%keyboard
ii=find(u_squared >= 0.0);
if ~isempty(ii),
  u_ip1(ii)=u_squared(ii).^0.5;
end
ii=find(u_squared < 0.0);
if ~isempty(ii),
     u_ip1(ii)=0.0*ones(1,length(ii));
     theta_i(ii)=theta(ii);
     salt_i(ii)=salt(ii);
end
%
% Calculate CFL condition
%
%cfl=time_step*abs(u_ip1)./(distance([2:n,n])-distance([1:n-1,n-1]));
%
% Solve the divergence equation (w=-h*du/dx )
%
w_ip1=solve_w(u_ip1,distance,thickness);
w_ip1=w_factor*w_ip1;
%
%
theta_tmp=-time_step*solve_heat_equation2(theta_i,theta,u_ip1,w_ip1,distance,thickness);
theta_tmp=theta_tmp/2+(theta_i(indexj)+theta_i(indexjp1))/2;
theta_m=(theta(indexj)+theta(indexjp1))/2;
%u_m=(u_ip1(indexj)+u_ip1(indexjp1))/2;
%w_m=(w_ip1(indexj)+w_ip1(indexjp1))/2;
theta_ip1=-time_step*solve_heat_equation2(theta_tmp,theta_m,u_ip1,w_ip1,distance,thickness);

%plot(distance,theta_ip1)
%pause

theta_ip1=theta_ip1+theta_i;

diffusion=theta_i;

source=zeros(size(theta_i));
source(1)=-2.0*(theta(2)-theta(1));
source(n)=2.0*(theta(n)-theta(n-1));

diffusion=K_h*(diffusion(jp1)-2*diffusion(j)+diffusion(jm1)+source);

theta_ip1=theta_ip1+diffusion;

ent_velocity=entrainment*(ones(size(u_ip1))+ factor*u_ip1);

theta_ip1=theta_ip1-time_step*ent_velocity.*(theta_ip1-theta)/thickness;

dthetadt_ip1=(theta_ip1-theta_i)/time_step;
%
%
salt_tmp=-time_step*solve_heat_equation2(salt_i,salt,u_ip1,w_ip1,distance,thickness);
salt_tmp=salt_tmp/2+(salt_i(indexj)+salt_i(indexjp1))/2;
salt_m=(salt_i(indexj)+salt_i(indexjp1))/2;
salt_ip1=-time_step*solve_heat_equation2(salt_tmp,salt_m,u_ip1,w_ip1,distance,thickness);
salt_ip1=salt_ip1+salt_i;

diffusion=salt_i;

source=zeros(size(theta_i));
source(1)=-2.0*(salt(2)-salt(1));
source(n)=2.0*(salt(n)-salt(n-1));

diffusion=K_h*(diffusion(jp1)-2*diffusion(j)+diffusion(jm1)+source);

salt_ip1=salt_ip1+diffusion;

ent_velocity=entrainment*(ones(size(u_ip1))+ factor*u_ip1);

salt_ip1=salt_ip1-time_step*ent_velocity.*(salt_ip1-salt)/thickness;

dsaltdt_ip1=(salt_ip1-salt_i)/time_step;
%
%
% Update the fields
%
u_im1=u_i;
w_im1=w_i;
theta_im1=theta_i;
salt_im1=salt_i;
delta_dens_im1=delta_dens_i;
%
u_i=u_ip1;
w_i=w_ip1;
theta_i=theta_ip1;
salt_i=salt_ip1;
delta_dens_i=delta_dens_ip1;
dthetadt_i=dthetadt_ip1;
dsaltdt_i=dsaltdt_ip1;
%
%
%
count=count+1;
if rem (count,plot_time_step) == 1,
%plot(distance,theta_ip1);
%plot(distance,salt_ip1);
%plot(distance,u_ip1);
%plot(distance,theta_tmp);
%plot(distance,salt_tmp);
%plot(distance,salt_ip1);
%plot(distance,u_ip1);
%plot(distance,w_ip1);
%plot(distance,delta_dens_ip1);
%hold on
%plot(distance,cfl)
%
%hold on
%pause
%
% Write the output to memory
%
count_output=count_output+1
theta_field(count_output,:)=theta_ip1;
dthetadt_field(count_output,:)=dthetadt_ip1;
salt_field(count_output,:)=salt_ip1;
dsaltdt_field(count_output,:)=dsaltdt_ip1;
delta_dens_field(count_output,:)=delta_dens_ip1;
u_field(count_output,:)=u_ip1;
w_field(count_output,:)=w_ip1;
time_field(count_output)=count*time_step;
end 
%
%
end
%
% write the data to the results file
%
save results_plume_model theta_field salt_field delta_dens_field ...
     u_field w_field time_field entrainment K_h thickness ...
     bottom_friction distance depth pressure density_background ...
     salt theta slope dthetadt_field



