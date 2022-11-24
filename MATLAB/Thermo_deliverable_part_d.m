%Downloading the data from NIST
%fullURL = 'https://webbook.nist.gov/cgi/fluid.cgi?Action=Data&Wide=on&ID=C7727379&Type=IsoBar&Digits=5&P=1&THigh=300&TLow=100&TInc=0.001&RefState=DEF&TUnit=K&PUnit=bar&DUnit=kg%2Fm3&HUnit=kJ%2Fmol&WUnit=m%2Fs&VisUnit=uPa*s&STUnit=N%2Fm';
%fileName = 'molar_enthalpy';
%urlwrite(fullURL,fileName)
%-------------------------------------------------------------
clear;clc;close all
R = 8.314; %J K-1 mol-1
values_NIST = xlsread('molar_enthalpy.xlsx');
temperatures = values_NIST(:,1);
molar_enthalpy_NIST = values_NIST(:,6);

%Theoretical molar enthalpy using h = 7RT/2 for diatomic ideal
molar_enthalpy_calc = 3.5*R*temperatures/1000; %to kJ

hold on
grid on
plot(temperatures,molar_enthalpy_NIST,LineWidth=1.4)
plot(temperatures,molar_enthalpy_calc,LineWidth=1.4)
legend({'Molar Enthalpy from NIST','Calculated Molar Enthalpy'},'Location','best')
xlabel('Temperature / K')
ylabel('Molar Enthalpy / kJ mol^{-1}')
title('Calculated and Actual (NIST) molar enthalpy values for Nitrogen from 100K to 300K')
set(gca,'FontSize',15)




