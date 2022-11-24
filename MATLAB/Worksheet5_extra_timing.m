clear; clc; close all
gamma = 1.4;
f = @(P,m) (1/gamma)*(m/P);

tic
for i = 1:100
    [P,m] = EulerSolver(f,[2000,100],40,10000);
end
toc

tic
for i = 1:10000
    [P,m] = ode45(f,[2000,100],40);
end
toc
%Defining Euler's method solution, basic implementation
function [P,m] = EulerSolver(f,Prange,m_initial,num_steps)
    %Initialize values:
    m(1) = m_initial; P(1) = Prange(1);
    step_size = (Prange(2)-Prange(1))/num_steps;

    for j = 1:num_steps
        gradient = f(P(j),m(j));
        m(j+1) = m(j)+gradient*step_size;
        P(j+1) = P(j) + step_size;
    end
end