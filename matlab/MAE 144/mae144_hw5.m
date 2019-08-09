close all; clear, clc

load angle_test.txt
a = angle_test(:,1);
g = angle_test(:,2);
f = angle_test(:,3);
tb = angle_test(:,4);
l = length(a);
dt = 50; % 50 ms
tmax = dt*l-50;
t = 0:dt:tmax;

figure(1)
plot(t,a)
hold
plot(t,g)
plot(t,f)
plot(t,tb)
xlabel('Time [ms]')
ylabel('Angle [rad]')
title('Angle vs. Time')
legend('Accel','Gyro','Filter','TaitBryan')