close all; clear, clc
load cog_angle_test.txt
y=cog_angle_test;
y(1:100,:)=[];
y1=y(:,1);
y2=y(:,2);
y3=y(:,3);
y4=y(:,4);
x=0:1:length(y1)-1;

figure()
plot(x,y1)
hold on
plot(x,y2)
plot(x,y3)
plot(x,y4)