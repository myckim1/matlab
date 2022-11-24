%Getting the files in the order of 140K, 126.19K, 110K)
%fullURL1 = 'https://webbook.nist.gov/cgi/fluid.cgi?Action=Data&Wide=on&ID=C7727379&Type=IsoTherm&Digits=5&PLow=0&PHigh=100&PInc=0.001&T=140&RefState=DEF&TUnit=K&PUnit=bar&DUnit=kg%2Fm3&HUnit=kJ%2Fmol&WUnit=m%2Fs&VisUnit=uPa*s&STUnit=N%2Fm';
%filename1 = 'isoterm_140';
%urlwrite(fullURL1,filename1)
%fullURL2 = 'https://webbook.nist.gov/cgi/fluid.cgi?Action=Data&Wide=on&ID=C7727379&Type=IsoTherm&Digits=5&PLow=0&PHigh=75&PInc=0.001&T=126.19&RefState=DEF&TUnit=K&PUnit=bar&DUnit=kg%2Fm3&HUnit=kJ%2Fmol&WUnit=m%2Fs&VisUnit=uPa*s&STUnit=N%2Fm';
%filename2 = 'isotherm_critical';
%urlwrite(fullURL2,filename2)
%fullURL3 = 'https://webbook.nist.gov/cgi/fluid.cgi?Action=Data&Wide=on&ID=C7727379&Type=IsoTherm&Digits=5&PLow=0&PHigh=75&PInc=0.001&T=110&RefState=DEF&TUnit=K&PUnit=bar&DUnit=kg%2Fm3&HUnit=kJ%2Fmol&WUnit=m%2Fs&VisUnit=uPa*s&STUnit=N%2Fm';
%filename3 = 'isotherm_110';
%urlwrite(fullURL3,filename3)

%Original Graph
clc; clear
Pv_vals = tdfread('Nitrogen.csv','tab');
isotherm_140 = xlsread('isoterm_140.xlsx');
isotherm_c = xlsread('isotherm_critical.xlsx');
isotherm_110 = xlsread('isotherm_110.xlsx');

specific_vol_liq = Pv_vals.Volume_0x28l0x2C_m30x2Fkg0x29;
specific_vol_vap = Pv_vals.Volume_0x28v0x2C_m30x2Fkg0x29;
pressure = Pv_vals.Pressure_0x28bar0x29;

critical_p = 33.958; %bar
critical_specificv = 1/313.300;%m^3kg^-1

semilogx(specific_vol_liq, pressure,'k',LineWidth=1.4);
hold on
semilogx(specific_vol_vap,pressure,'k',LineWidth=1.4);
plot(critical_specificv,critical_p,'.k','MarkerSize',20)

%New Isotherms
isotherm_140_vol = isotherm_140(:,3).^(-1);
isotherm_140_pressure = isotherm_140(:,2);

isotherm_c_vol = isotherm_c(:,4);
isotherm_c_pressure = isotherm_c(:,2);

isotherm_110_vol = isotherm_110(:,4);
isotherm_110_pressure = isotherm_110(:,2);

semilogx(isotherm_140_vol,isotherm_140_pressure,LineWidth=1.6)
semilogx(isotherm_c_vol,isotherm_c_pressure,LineWidth=1.6)
semilogx(isotherm_110_vol,isotherm_110_pressure,LineWidth=1.6)

%Plot tweaking (To make it look as nice as possible)
title('Isothermal Pv data for different Temperatures, superimposed on Pv representation of Nitrogen')
set(gca,'FontSize',16)
xlim([10^-3.2,2])
ylim([0,45])
xlabel(['Specific Volume / m^{' num2str(3) '} kg^{' num2str(-1) '}'],'FontSize',16)
ylabel('Pressure / bar','FontSize',16)
text(critical_specificv-10^-3.2,critical_p+1.1,'Critical Point','FontSize',14)
text(10^-3.05,20,"L",'FontSize',18)
text(10^-1.55,20,"V",'FontSize',18)
text(10^-1.7,42,'Supercritical','FontSize',18)
text(10^-2.47,13,"  VLE",'FontSize',18)
text(10^-2.6,10.5,"  Vapour + Liquid Phase",'FontSize',12)
set(text(10^-2.72,18,'Saturated Liquid','FontSize',16),'Rotation',80)
set(text(10^-2.23,28,'Saturated Vapour','FontSize',16),'Rotation',305)

legend({'','','','T=140K','T=126.19K','T=110K'},'FontSize',14)