%
%
% Position of peak
%
%load results_plume_model
figure(11)
[maximum_speed,index]=max(u_field');
position_maximum=distance(index);
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Velocity (m.s-1)')
xlabel('Distance (m)')
plot(position_maximum,maximum_speed);
%
% Speed of peak
%
figure(12)
peak_speed=(position_maximum(2:48)-position_maximum(1:47))/1800;
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Velocity (m.s-1)')
xlabel('Distance (m)')
plot(position_maximum(1:47),peak_speed);
%
figure(13)
title(['Entrainment ',num2str(entrainment),' Difussivity ',num2str(K_h)])
ylabel('Velocity (m.s-1)')
xlabel('Velocity (m.s-1)')
plot(maximum_speed(1:47),peak_speed);
hold on
plot([0,2],[0,2])
hold off
