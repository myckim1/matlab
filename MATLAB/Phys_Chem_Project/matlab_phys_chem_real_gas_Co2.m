%Plotting saturation curve (P-v) with Isotherm Plots (Calculated from VDW)
clear;clc; close all
%Below used to download saturation (Pressure increment) data for CO2.
%url = 'https://webbook.nist.gov/cgi/fluid.cgi?Action=Data&Wide=on&ID=C124389&Type=SatT&Digits=5&PLow=5.1795&PHigh=73.773&PInc=0.0001&RefState=DEF&TUnit=K&PUnit=bar&DUnit=kg%2Fm3&HUnit=kJ%2Fmol&WUnit=m%2Fs&VisUnit=Pa*s&STUnit=N%2Fm';
%websave('co2_100bar_saturation.csv',url);

saturation_data = readtable('co2_100bar_saturation.csv');
saturation_data=table2array(saturation_data);

%Necessary physical Constants
R_mol = 8.3144626; %in J K^-1 mol^-1
molar_mass_CO2 = 0.04401; %kg mol^-1

%Critical Point (From NIST webbook fluids)
crit_v=1./467.6; crit_p=73.773*10^5; crit_T=304.1282;%P in Pa, T in Kelvin

%P-(Specific Volume) Plot. Creating the volume and pressure variables
%Liq = Liquid, Vap = Vapour
liq_sat_v = saturation_data(:,4);
vap_sat_v = saturation_data(:,16);

sat_p = saturation_data(:,2);

%Calculating Predicted Isotherm plots using Van Der Waals Real Gas Equation
%a,b constants for CO2 Use a = (27R^2 Crit_T^2)/(64Crit_P)
%b=R*Crit_T/(8Crit_P). R_mass_CO2 used for plot
a = (27*R_mol^2*crit_T.^2)./(64*crit_p);
b = R_mol*crit_T./(8*crit_p);

%Convert a and b to units used in plot
a = a./(molar_mass_CO2.^2);
b = b./(molar_mass_CO2);

%Creating an annonymous function to speed up calculations
vdw_p = @(v,T) ((R_mol./molar_mass_CO2)*T*(v-b).^-1)-a*(v.^-2);

 %Get the domain
vols = logspace(-3.5,0.1,500);

 %Create the VDW Isotherms
vdw_260 = vdw_p(vols,260)/100000; %Covert to bar
vdw_273 = vdw_p(vols,273)/100000; %0 C
vdw_293 = vdw_p(vols,293)/100000; %20 C ~ Room Temp
vdw_350 = vdw_p(vols,350)/100000; %Supercritical

%Plotting the values
loglog(liq_sat_v,sat_p,LineWidth=2)
hold on
plot(vap_sat_v,sat_p,LineWidth=2)
plot(crit_v,crit_p/100000,'k.',MarkerSize=20)

%Plot VDW Isotherms
vdw_plot_width = 1.5;
plot(vols,vdw_260,'--',LineWidth=vdw_plot_width)
plot(vols,vdw_273,'--',LineWidth=vdw_plot_width)
plot(vols,vdw_293,'--',LineWidth=vdw_plot_width)
plot(vols,vdw_350,'--',LineWidth=vdw_plot_width)

%Axes customisation
xlim([0.0005,0.1])
xlabel('\bf Specific Volume / m^{3}kg^{-1}')

ylim([4,520])
ylabel('\bf Pressure / bar')
yticks([5.11,10,100,500]);yticklabels({'5.11','10','100','500'})
title("\bf Pv plot of Isotherms calculated from VDW")

set(gca,'FontSize',12)
legend_labels={'Saturated Liquid',"Saturated Vapour","Critical Point","Real Gas: 260K","Real Gas: 273K","Real Gas: 293K","Real Gas: 350K"};
legend(legend_labels,FontSize=10)
grid on


