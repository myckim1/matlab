%Euler's method
clear, clc, close all
k1 = 1.6e-3;

f = @(t,N) -N*k1;

xrange = [0,1000];

yinitial = 0.3;

[t,N] = EulerSolver(f,xrange,yinitial,50);
plot(t,N,'c-','linewidth',2), hold on
[t, N] = EulerSolver(f, xrange, yinitial, 5); % 5 steps
plot(t,N,'b-','linewidth',2)
[t, N] = EulerSolver(f, xrange, yinitial, 2); % 2 steps
plot(t,N,'m-','linewidth',2)

x=linspace(0,1000);
plot(x, yinitial*exp(-k1*x),'k--','linewidth',2);
% Configure the plot
grid on
xlabel('t/years','fontname','Times','fontangle','italic')
ylabel('m/mcg','fontname','Times','fontangle','italic')
legend('50 steps', '5 steps', '2steps','exact','Location','northeast')
function [x,y] = EulerSolver(f,xrange,yinitial, numstep)
    x(1) = xrange(1); y(1) = yinitial;
    step_size = (xrange(2)-xrange(1))/numstep;
    
    for j = 1:numstep
        gradient = f(x(j),y(j));
        y(j+1) = y(j)+gradient*step_size;
        x(j+1) = x(j)+step_size;
    end
end