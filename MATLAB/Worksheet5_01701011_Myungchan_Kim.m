% Euler's Method:
clear; clc; close all
gamma = 1.4;
f = @(P,m) (1/gamma)*(m/P);

%Leaving units in P = kPa and m = kg
[P,m] = EulerSolver(f,[2000,100],40,100);
plot(P,m)

%Analytical
m_analytical = @(m0,P,P0,gamma) m0*(P/P0).^(1/gamma);
P = linspace(2000,100,1000);
hold on;
plot(P,m_analytical(40,P,2000,1.4))

%Graph Axes
title("Solutions to Thermodynamics Problem: Analytical vs Euler Method")
xlabel("Pressure / kPa"); ylabel("Mass / kg")
legend("Using Euler's Method","Using Analytical Solution")
set(gca,'FontSize',15)
%Using ode45

figure(2)
gamma = 1.4;
f = @(P,m) (1/gamma)*(m/P);
[P,m] = ode45(f,[2000,100],40);
plot(P,m)

%Analytical
m_analytical = @(m0,P,P0,gamma) m0*(P/P0).^(1/gamma);
P = linspace(2000,100,1000);
hold on;
plot(P,m_analytical(40,P,2000,1.4))

title("Solutions to Thermodynamics Problem: Analytical vs Ode45")
xlabel("Pressure / kPa"); ylabel("Mass / kg")
legend("Using ode45","Using Analytical Solution")
set(gca,'FontSize',15)
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