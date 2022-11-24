% prepare the workspace
clear; clc

%Prepare x & y (and other possibilities for x)
x = linspace(0,2*pi,500);
x2 = 0:0.01:2*pi; %This gives 629 points spaced out by 0.01.

y_sin = sin(x); %x2 should give a very similar result
y_cos = cos(x);

%Plotting
plot(x,y_sin,"r")
hold on; %To plot on the same set of axes
plot(x,y_cos,"b")
hold off;

%Formatting the plot
xlabel("x (rad)")
ylabel("y")
title("Plot of sin(x) and cos(x)")
yline(0)
legend("sin(x)","cos(x)","Location","best")

xlim([0,2*pi])
xticks([0,pi/2,pi,3*pi/2,2*pi])
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
