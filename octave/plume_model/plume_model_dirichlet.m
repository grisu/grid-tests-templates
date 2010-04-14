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
entrainment=0.01 % Entrainment parameter
bottom_friction=0.001  % Bottom friction
thickness=100 % Bottom layer thickness
time_step=20        % time step in seconds
%
% Initialise the background fields
%
load background_fields
%pressure=
%distance=
%theta=
%salt=
%slope=u_
%
% Calculate the derivative at the end points for the 
% background field.
%
n=length(theta);
dthetadx=(theta([2:n,n])-theta([1:n-1,n-1])) ...
          ./(distance([2:n,n])-distance([2:n,n]));
dsaltdx=(salt([2:n,n])-salt([1:n-1,n-1])) ...
          ./(distance([2:n,n])-distance([2:n,n]));
%
%
%
%
%
% Calculate gravity 
%
g=9.82*slope;
%
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
jp1=indexjp1;
j=indexj;
jm1=indexjm1;
%
% Inject jet at beginning of flow
%
n=length(theta);
     theta_anomaly=-0.2*exp(-(([1:n]-50*ones(1,n))/5).^2);
     salt_anomaly=0.1*exp(-(([1:n]-50*ones(1,n))/5).^2);
theta_i=theta_i+theta_anomaly;
salt_i=salt_i+salt_anomaly;
%u_i(1)=0.01;
%
%
% Calculate the density outside the plume
%
density_background=sigma(pressure,theta,salt);
%
%
count=1
for i=1:3000
%
% Calculate the density inside the plume
%
density_ip1=sigma(pressure,theta_i,salt_i);
%
% Calculate the density difference
%
delta_dens_ip1=density_ip1-density_background;
%
% Test flow for positive buoyancy
%
% Calculate the downslope velocity
%
ii=find(delta_dens_ip1 >= 0.0);
if ~isempty(ii),
    u_ip1(ii)=(2/bottom_friction.*g(ii).*delta_dens_ip1(ii)).^(1/2);
end
ii=find(delta_dens_ip1 < 0.0);
if ~isempty(ii),
    u_ip1(ii)=-(2/bottom_friction.*g(ii).*abs(delta_dens_ip1(ii))).^(1/2);
end
%
% Calculate CFL condition
%
cfl=time_step*abs(u_ip1)./(distance([2:n,n])-distance([1:n-1,n-1]));
%
% Solve the divergence equation (w=-h*du/dx )
%
w_ip1=solve_w(u_ip1,distance,thickness);
w_ip1=0*w_ip1;
%
%
theta_tmp=-time_step*solve_heat_equation2(theta_i,theta,u_ip1,w_ip1,distance,thickness,entrainment);
theta_tmp=theta_tmp/2+(theta_i(indexj)+theta_i(indexjp1))/2;
theta_m=(theta(indexj)+theta(indexjp1))/2;
%u_m=(u_ip1(indexj)+u_ip1(indexjp1))/2;
%w_m=(w_ip1(indexj)+w_ip1(indexjp1))/2;
theta_ip1=-time_step*solve_heat_equation2(theta_tmp,theta_m,u_ip1,w_ip1,distance,thickness,entrainment);
theta_ip1=theta_ip1+theta_i;
%theta_ip1=theta_ip1+(theta_i(indexjm1)+theta_i(indexjp1))/2;


%theta_ip1(1)=theta(1);
%theta_ip1(n)=theta(n);


diffusion=theta_i;

source=zeros(size(theta_i));
source(1)=-2.0*(theta(2)-theta(1));
source(n)=2.0*(theta(n)-theta(n-1));

diffusion=0.40*(diffusion(jp1)-2*diffusion(j)+diffusion(jm1)+source);
theta_ip1=theta_ip1+diffusion;
%
%
salt_tmp=-time_step*solve_heat_equation2(salt_i,salt,u_ip1,w_ip1,distance,thickness,entrainment);
salt_tmp=salt_tmp/2+(salt_i(indexj)+salt_i(indexjp1))/2;
salt_m=(salt_i(indexj)+salt_i(indexjp1))/2;
salt_ip1=-time_step*solve_heat_equation2(salt_tmp,salt_m,u_ip1,w_ip1,distance,thickness,entrainment);
salt_ip1=salt_ip1+salt_i;

diffusion=salt_i;

source=zeros(size(theta_i));
source(1)=-2.0*(salt(2)-salt(1));
source(n)=2.0*(salt(n)-salt(n-1));

diffusion=0.40*(diffusion(jp1)-2*diffusion(j)+diffusion(jm1)+source);

salt_ip1=salt_ip1+diffusion;

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
%
%
%
count=count+1;
if rem (count,100) == 1,
%plot(distance,theta_ip1);
plot(distance,salt_ip1);
%plot(distance,u_ip1);
hold on
%plot(distance,theta_tmp);
%plot(distance,salt_tmp);
%plot(distance,salt_ip1);
%plot(distance,u_ip1);
%plot(distance,w_ip1);
%plot(distance,delta_dens_ip1);
%plot(distance,cfl)
%
%hold on
%pause
end 
%pause (1)
%
%
end
