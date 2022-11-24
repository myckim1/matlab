%Visocity plots, and the real gas vs ideal gas plot.
clear;clc; close all
%url = 'https://webbook.nist.gov/cgi/fluid.cgi?Action=Data&Wide=on&ID=C124389&Type=IsoBar&Digits=5&P=1&THigh=2000&TLow=0&TInc=0.0001&RefState=DEF&TUnit=K&PUnit=atm&DUnit=kg%2Fm3&HUnit=kJ%2Fmol&WUnit=m%2Fs&VisUnit=Pa*s&STUnit=N%2Fm';
%websave('exp_data_viscosity_vap.csv',url);
nist_data = readtable('exp_data_viscosity_vap.csv');
nist_data = table2array(nist_data(:,1:end-1)); %Exclude Phase column

m = 0.04401./(6.02214086*10^23); %Mr/Na
k = 1.38064852 * 10^-23; %Boltzmann Constant
A = 0.52*10^-18; %Convert nm2 to m2
max_T = 1000;
x = 216:0.01:max_T;
visc_gas = (2/3)*((m*k.*x./pi).^0.5)*1./A;
plot(x,visc_gas,LineWidth=1.5)

hold on
%Plotting the experimental plot
visc_exp = nist_data(:,12);
x_exp = nist_data(:,1);
plot(x_exp(x_exp<max_T),visc_exp(x_exp<max_T),LineWidth=1.5)

xlim([0,1250])
ylim([0,0.000045])

yticks(0:0.00001:0.0001)
yticklabels({'0','0.00001','0.00002','0.00003','0.00004','0.00005','0.00006','0.00007','0.00008','0.00009','0.00010'})

ylabel("\bf Viscosity(\eta) / kg m^{-1}s^{-1}")
xlabel("\bf Temperature / K")
title("\bf Predicted and Experimental Viscosity of CO_{2} over Temperature")

set(gca,'FontSize',12)
legend({"Predicted Values","Experimental Data (NIST)"},'FontSize',11)
grid on
%-------------------------------Figure 3 liquid---------------------------
figure(2)
nist_data_liq = readtable('exp_data_viscosity_liq.csv');
nist_data_liq = table2array(nist_data_liq(:,1:end-1)); %Exclude Phase column

x=nist_data_liq(2:1:497,1);
y=nist_data_liq(2:1:497,12);

plot(x,y)
ylabel("\bf Viscosity(\eta) / kg m^{-1}s^{-1}")
xlabel("\bf Temperature / K")
title("\bf Experimental (NIST) Viscosity of liquid CO_{2}")