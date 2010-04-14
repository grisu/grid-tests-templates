%
%
%load results_plume_model_exp2.mat
%load results_plume_model_exp7
%load results_plume_model
%load results_plume_model_exp9.mat
%clear distance pressure depth
%load background_fields.mat
%

figure(1)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
xlabel('Distance (m)')
ylabel('Salinity (pss)')
plot(distance, salt_field)
%
figure(2)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
xlabel('Distance (m)')
ylabel('Theta (C)')
plot(distance, theta_field)
%
figure(3)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
xlabel('Distance (m)')
ylabel('Density anomaly (kg/m-3)')
plot(distance, delta_dens_field)
%
figure(4)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
xlabel('Salinity (pss)')
ylabel('Theta (C)')
[m,n]=size(salt_field)
plot(salt_field(1,:), theta_field(1,:), '-')
hold on
for i=2:m
    plot(salt_field(i,:), theta_field(i,:), '-')
end
hold off
%
% Calculate entrainments factors for density
%
figure(5)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Density anomaly (kg.m-3)')
xlabel('Distance (m)')
result=sum(delta_dens_field')
plot(1:48, result)
%
% Calculate entrainments factors for salt
%
figure(6)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Salt anomaly pss')
xlabel('Distance (m)')
result=sum((salt_field-salt(ones(48,1),:))')
plot(1:48, result)
%
% Calculate entrainments factors for theta
%
figure(7)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Theta anomaly (C)')
xlabel('Distance (m)')
result=sum((theta_field-theta(ones(48,1),:))')
plot(1:48, result)
%
% Calculate vertical profile density
%
figure(8)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Density anomaly (kg.m-3)')
xlabel('Depth (m)')
density_background=sigma_thermobaric(pressure,theta,salt);
plot(pressure,density_background);
hold on
plot(pressure,sigma_thermobaric(pressure(ones(48,1),:),theta_field,salt_field));
hold off
%
% Velocities 
%
figure(9)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Velocity (m.s-1)')
xlabel('Distance (m)')
plot(distance,u_field);
hold off
%
% Velocities 
%
figure(10)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Vertical Velocity (m.s-1)')
xlabel('Distance (m)')
plot(distance,w_field);
hold off
%
%
%
% Position of peak
%
plot_speeds

