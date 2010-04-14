%
%
clear
load results_plume_model
%
%
figure(1)
hold off
title(['Plume model ', ' Difussivity ',num2str(K_h)])
xlabel('Distance (m)')
ylabel('Depth m')
plot(distance, depth)
hold on
depth_plume=depth(ones(12,1),:)+2*thickness_field(1:4:48,:);
plot(distance, depth_plume)
hold off

figure(2)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
xlabel('Salinity (pss)')
ylabel('Theta (C)')
[m,n]=size(salt_field)
plot(salt, theta, '-')
hold on
for i=1:4:m
    plot(salt_field(i,:), theta_field(i,:), '-')
end
hold off
