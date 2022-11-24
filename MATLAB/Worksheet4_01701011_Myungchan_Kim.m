clear, clc
% --------------------Base Code-----------------------------------------
figure(1)
m_dot = 10:0.02:30; %Set the "x-axis" for plot

P = @(m) -0.0075*m.^2+0.1750*m+4; %4c.1 equation
P2 = @(P0,m,z,k) P0+(m/(z*k)).^2; %4c.2 equation rearranged for P
%But in this problem, P0 = 1, k = 25

plot(m_dot,P(m_dot),"LineWidth",2) %Part (i)
hold on; %Plot on the same set of axes

%Plotting the 3 different plots for differing 'k' part(iii)
plot(m_dot,P2(1,m_dot,0.25,25),'LineWidth',2)
plot(m_dot,P2(1,m_dot,0.5,25),'LineWidth',2)
plot(m_dot,P2(1,m_dot,0.75,25),'LineWidth',2)
hold off;

%Graph settings
xlabel('Mass Flow/ kg s^-1')
ylabel('Pressure/ bar')
ylim([0,10])
title("Plot of equations 4c.1 and 4c.2 with varying k values")
legend('','k = 0.25','k = 0.5','k = 0.75')

% ---------------Trialing with individual points first.------------------
%I created a "discharge_pressure" function for fsolve
P0=1; k=25; z = 0.5; %(Given constants)

f = @(x) discharge_pressure(x,P0,z,k);
xtrial = [11,1.3]; %A single point

%Solve for [mass, pressure] for the 2 given equations, with the given
%constants
sol_trial = fsolve(f,xtrial);

%--------------------------Part (iv)------------------------------
P0=1; k=25; %Given values from other parts of the question
x_guess1 = [25,2];

counter = 0;
ind = 0:0.001:1;
for z = ind
    counter = counter+1;
    f = @(x) discharge_pressure(x,P0,z,k);

    sol = fsolve(f,x_guess1);
    
    %Create an overall matrix with values I could've looped it but didn't
    %think it was necessary for 3 variables.
    values_matrix(counter,1) = z;
    values_matrix(counter,2) = sol(1);
    values_matrix(counter,3) = sol(2);
    clc
end
%The Values matrix is structured as follows: col1: z value
% Col2: mass values, Col3: Pressure values
%I did this to make all data more accessible.

%Find z values where m = 10, m = 30
%Go through values_matrix and look for the first value above m =10. Just
%use the corresponding value for z.

%First filter for where mass is greater than 10, and then take the first
%value for Z. This filtered value just returns z values.
mass_above_10 = values_matrix(values_matrix(:,2)>10);
z_mass_10 = mass_above_10(1);
%Do the same for m = 30
mass_above_30 = values_matrix(values_matrix(:,2)>30);
z_mass_30 = mass_above_30(1);

%Plotting the graph
figure(2)
plot(ind,values_matrix(:,2))
title("Mass values depending on Z")
xlabel("Z")
ylabel("Mass/ kg s^-1")
yline(10,'--')
yline(30,'--')
%Descriptions of the 2 points, Some adjustments to make text readable.
hold on
plot(0.2000,values_matrix(200,2),'o',MarkerSize=10)
plot(0.980,values_matrix(980,2),'o',MarkerSize=10)

text(0.2000,values_matrix(200,2)-2,"m = 10 at z = 0.200")
text(0.6500,values_matrix(980,2)-2,"m = 30 at z = 0.980")
hold off

%Plot z vs Pressure
figure(3)
plot(ind,values_matrix(:,3))
title("Pressure values depending on Z")
xlabel("Z")
ylabel("Pressure/ bar")

xline(0.200,'--')
xline(0.980,'--')
hold on
plot(0.2000,values_matrix(200,3),'o',MarkerSize=10)
plot(0.980,values_matrix(980,3),'o',MarkerSize=10)
hold off
text(0.2000,values_matrix(200,3)+0.1,"P = 5.0000 at z = 0.200")
text(0.6500,values_matrix(980,3),"P = 2.4995 at z = 0.980")

%-----------Function for unknowns: mass flow rate and pressure----------
function func = discharge_pressure(x,P0,z,k)
    m = x(1);
    P = x(2);
    func(1) = -0.0075*m.^2+0.1750*m+4-P;
    func(2) = z*k*sqrt(P-P0) - m;
end

