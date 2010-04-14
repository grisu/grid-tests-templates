%
%
% Test routine to see if the fluxes make sense at each time step
%
clear
load results_plume_model
[m,n]=size(u_field);
%distance_div=(distance([2,3:n,n])-distance([1,1:n-2,n-1]));
distance_div=(distance([2:n,n])-distance([1:n-1,n-1]));
%
% First mass conservation
%
% Horizontal fluxes 
Hor_mass_flux=thickness*u_field;
%hor_mass_div=Hor_mass_flux(:,[2,3:n,n])-Hor_mass_flux(:,[1,1:n-2,n-1]);
hor_mass_div=Hor_mass_flux(:,[2:n,n])-Hor_mass_flux(:,[1:n-1,n-1]);
%
% vertical flux
%
ver_mass_flux=distance_div(ones(m,1),:).*w_field;
ver_mass_div=ver_mass_flux;
%ver_mass_div=(ver_mass_flux(:,[1,1:n-1])+ver_mass_flux(:,[1,2:n]))/2;
%
% Total divergence
tot_mass_div=hor_mass_div+ver_mass_div;
%
figure(1)
%for i=1:m
for i=2:2
plot(distance(1:n),tot_mass_div(i,:))
hold on
plot(distance(1:n),ver_mass_div(i,:))
plot(distance(1:n),hor_mass_div(i,:))
end
hold off
%
%
% Now calculate the salt and heat fluxes
%
%
% Horizontal heat fluxes 
Hor_heat_flux=thickness*u_field.*theta_field;
hor_heat_div=Hor_mass_flux(:,[2,3:n,n])-Hor_mass_flux(:,[1,1:n-2,n-1]);
hor_heat_div=Hor_mass_flux(:,[2:n,n])-Hor_mass_flux(:,[1:n-1,n-1]);
%
%
% vertical heat flux
%
ver_heat_flux=distance_div(ones(m,1),:).*w_field.*(theta(ones(m,1),:)-theta_field);
ver_heat_div=ver_mass_flux;
%
%
% entrainment heat flux
%
ver_entrainment_flux=entrainment.*(theta(ones(m,1),:)-theta_field);
%
%  storage term 
%
heat_storage=thickness*dthetadt_field;
%
% Total divergence
%tot_heat_div=hor_heat_div+ver_heat_div+ver_entrainment_flux+heat_storage;
%tot_heat_div=hor_heat_div+ver_heat_div+heat_storage;
tot_heat_div=hor_heat_div+ver_heat_div;
%
%
figure(2)
%hold on
%for i=1:m
for i=2:2
plot(distance(1:n),tot_heat_div(i,:))
     pause(1)
hold on
plot(distance(1:n),ver_heat_div(i,:))
plot(distance(1:n),hor_heat_div(i,:))
plot(distance(1:n),ver_entrainment_flux(i,:))
     pause(1)
plot(distance(1:n),heat_storage(i,:))

end
hold off
