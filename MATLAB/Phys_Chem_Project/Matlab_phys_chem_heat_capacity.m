clear ;clc; close all
sigmoid = @(theta,T) (((theta./T).^2).*exp(theta./T))./(exp(theta./T)-1).^2;

R=8.31446; 
x = 0:0.01:6000;
rotational_contr = fillmissing(sigmoid(0.551,x),'constant',0);
v1_contr = fillmissing(sigmoid(1920,x),'constant',0);
v2_contr = 2.*fillmissing(sigmoid(960,x),'constant',0);
v3_contr = fillmissing(sigmoid(3380,x),'constant',0);
y_cv=R.*(1.5+rotational_contr+v1_contr+v2_contr+v3_contr);

semilogx(x,y_cv,LineWidth=2);
hold on

xline(0.551, LineWidth=1.3)
xline(960,LineWidth=1.3); xline(3380,LineWidth=1.3); xline(1920,LineWidth=1.3)

xlim([0,15000]);
ylim([0,60]);
xlabel("\bf Temperature / K");
ylabel("\bf C_{v} / J K^{-1} mol^{-1}");
xticks([0.01 0.1 1 10 100 1000 10000])
xticklabels([0.01 0.1 1 10 100 1000 10000])

title("\bf Molar C_{v} of CO_{2} over Temperature")
set(gca,'FontSize',12)
legend({"Predicted Values"},'FontSize',12)
grid on

hold off
%---------------------------------------------------------------------------
figure(2)
x_exp = horzcat(175:25:400,450:50:1400,1500:100:3000,3500:500:6000);
y_exp = 44.01.*[0.709 0.735 0.763 0.791 0.819 0.846 0.871 0.895 0.918 0.939 0.978 1.014 1.046 1.075 1.102 1.126 1.148 1.168 1.187 1.204 1.220 1.234 1.247 1.259 1.270 1.280 1.290 1.298 1.306 1.313 1.326 1.338 1.348 1.356 1.364 1.371 1.377 1.383 1.388 1.393 1.397 1.401 1.404 1.408 1.411 1.414 1.427 1.437 1.446 1.455 1.465 1.476];

y_cp=y_cv+R;
semilogx(x,y_cp,LineWidth=1.3)
hold on
plot(x_exp,y_exp, 'k.','MarkerSize',8)
xline(0.551, LineWidth=1.3)
xline(960,LineWidth=1.3); xline(3380,LineWidth=1.3); xline(1920,LineWidth=1.3)
xticks([0.01 0.1 1 10 100 1000 10000 100000])
xticklabels([0.01 0.1 1 10 100 1000 10000 100000])

xlim([0,15000]);
ylim([0,70]);
xlabel("\bf Temperature / K");
ylabel("\bf C_{p} / J K^{-1} mol^{-1}");
title("\bf Predicted and Experimental Molar C_{p} of CO_{2} over Temperature")

set(gca,'FontSize',14)
legend({"Predicted Values","Experimental Data (NIST)"},'FontSize',12)
grid on