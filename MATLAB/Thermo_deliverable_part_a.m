clear; clc
vals = tdfread('Nitrogen.csv','tab'); %Local file in laptop, downloaded from NIST

specific_vol_liq = vals.Volume_0x28l0x2C_m30x2Fkg0x29;
specific_vol_vap = vals.Volume_0x28v0x2C_m30x2Fkg0x29;
pressure = vals.Pressure_0x28bar0x29;

critical_p = 33.958; %bar
critical_specificv = 1/313.300;%m^3kg^-1

semilogx(specific_vol_liq, pressure,'k',LineWidth=1.4);
hold on
semilogx(specific_vol_vap,pressure,'k',LineWidth=1.4);
plot(critical_specificv,critical_p,'.k','MarkerSize',20)
title('Pv representation of vapour-liquid coexistence phase envelope for Nitrogen','FontSize',14)

set(gca,'FontSize',16)
xlim([10^-3.2,2])
ylim([0,45])
xlabel(['Specific Volume / m^{' num2str(3) '} kg^{' num2str(-1) '}'],'FontSize',16)
ylabel('Pressure / bar','FontSize',16)

%Labelling
text(critical_specificv-10^-3,critical_p+1.1,'Critical Point','FontSize',14)
text(10^-3.05,20,"L",'FontSize',18)
text(10^-1.55,20,"V",'FontSize',18)
text(10^-1.7,42,'Supercritical','FontSize',18)
text(10^-2.47,15,"  VLE",'FontSize',18)
text(10^-2.6,12.5,"  Vapour + Liquid Phase",'FontSize',12)
set(text(10^-2.84,13,'Saturated Liquid','FontSize',16),'Rotation',82)
set(text(10^-2,23,'Saturated Vapour','FontSize',16),'Rotation',308)
box_str = {["Critical Specific Volume: 3.192·10^{-3} kg m^{-3}"],["Critical Pressure: 33.96 bar"]};
annotation('textbox', [0.66, 0.55, 0.1, 0.1], 'String', box_str,FontSize=12)
