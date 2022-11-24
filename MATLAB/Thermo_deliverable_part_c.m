%First, calculate the isotherm data using VDW equation
clear;clc;close all
a = 174.2; %In Nm^4kg^-2
b = 1.379*10^-3 ; %m^3kg^-1
Mr = 0.0280134; %From NIST
R = 8.314/(Mr); %kg m2 s-2 K-1 Kg-1 = J K-1 kg-1

%Make vdw function
vdw_p = @(v,T) (R*T*(v-b).^-1)-a*(v.^-2);

%Get the domain
vols = logspace(-3,0.6,600); %Create 600 points
vols = vols(vols>b); %Introduce the condition

%Create the VDW Isotherms
vdw_140 = vdw_p(vols,140)/100000;
vdw_crit = vdw_p(vols,126.19)/100000;
vdw_110 = vdw_p(vols,110)/100000;

%Actual Values (NIST)
Pv_vals = tdfread('Nitrogen.csv','tab');
isotherm_140 = xlsread('isoterm_140.xlsx');
isotherm_c = xlsread('isotherm_critical.xlsx');
isotherm_110 = xlsread('isotherm_110.xlsx'); 
isotherm_140_vol = isotherm_140(:,3).^(-1);
isotherm_140_pressure = isotherm_140(:,2);

isotherm_c_vol = isotherm_c(:,4);
isotherm_c_pressure = isotherm_c(:,2);

isotherm_110_vol = isotherm_110(:,4);
isotherm_110_pressure = isotherm_110(:,2);

%Get the Pv representation
specific_vol_liq = Pv_vals.Volume_0x28l0x2C_m30x2Fkg0x29;
specific_vol_vap = Pv_vals.Volume_0x28v0x2C_m30x2Fkg0x29;
pressure = Pv_vals.Pressure_0x28bar0x29;

critical_p = 33.958; %bar
critical_specificv = 1/313.300;%m^3kg^-1

semilogx(specific_vol_liq, pressure,'k',LineWidth=1.4);
hold on
semilogx(specific_vol_vap,pressure,'k',LineWidth=1.4);
plot(critical_specificv,critical_p,'.k','MarkerSize',20)

%VDW & Actual for T = 140K
semilogx(isotherm_140_vol,isotherm_140_pressure,color=[0,1,0.8],LineWidth=1.6)
semilogx(vols,vdw_140,'b--',LineWidth=1.6)

%For T = Critical
semilogx(isotherm_c_vol,isotherm_c_pressure,'g-',LineWidth=1.6)
semilogx(vols,vdw_crit,color=[0 0.55 0],LineStyle='--',LineWidth=1.6)

%For T = 110K
semilogx(isotherm_110_vol,isotherm_110_pressure,color=[0.88 0.69 0.9],LineWidth=1.6)
semilogx(vols,vdw_110,'--',color=[0.4940, 0.1840, 0.5560],LineWidth=1.6)

%Plot tweaking (To make it look as nice as possible)
title("Isothermal Pv data for different Temperatures, compared to Pv calculated from Van der Waal's equation")
set(gca,'FontSize',16)
xlim([10^-3.2,2])
ylim([0,50])
xlabel(['Specific Volume / m^{' num2str(3) '} kg^{' num2str(-1) '}'],'FontSize',16)
ylabel('Pressure / bar','FontSize',16)

text(critical_specificv-10^-3.2,critical_p-1.1,'Critical Point','FontSize',10)
text(10^-3.05,20,"L",'FontSize',18)
text(10^-1.55,20,"V",'FontSize',18)
text(10^-1.7,42,'Supercritical','FontSize',18)
text(10^-2.2,13,"  VLE",'FontSize',18)
text(10^-2.33,10.5,"  Vapour + Liquid Phase",'FontSize',12)
set(text(10^-2.75,17,'Saturated Liquid','FontSize',12),'Rotation',80)
set(text(10^-2.32,31.5,'Saturated Vapour','FontSize',12),'Rotation',305)

h = line(nan, nan, 'Color', 'none'); %This is to add text at the bottom of the Legend
legend({'','','','NIST T = 140K','VDW T = 140K','NIST T = 126.19K','VDW T = 126.19K','NIST T = 110K','VDW T = 110K',"VDW: Calculated with Van der Waal's Equation"},'FontSize',12)