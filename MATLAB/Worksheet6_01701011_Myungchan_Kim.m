clear;clc;close all
%Retrieving the data
[data,text,~] = xlsread("BoilingPointData.xlsx");
%data is the whole excel file, text contains the chemical names.
%This function already omitted out the headers.
%Col 3: Molweight, 4: Critical Temp, 5: acentric factor, 6: boiling point.
%---------------------PART A----------------------------------------------
molar_weight = data(:,3);
boiling_point = data(:,6);

plot(molar_weight,boiling_point,'o','MarkerSize',4)
%fitting the data as a linear function
p_linear = polyfit(molar_weight,boiling_point,1);
yp_linear = polyval(p_linear,molar_weight);

[R,p] = corrcoef(molar_weight,boiling_point);
hold on
plot(molar_weight, yp_linear,LineWidth=2)
annotation('textbox',[0.7 0.1 0.3 0.3],'String',"R^{2}="+ string((R(1,2)).^2),'FitBoxToText','on');

legend("Actual Data", "Linear Fit")
title("Crtical Temperature plotted against molecular weight")
xlabel('Molecular Weight (g mol{-1})'); ylabel("Boiling Point Temperature (K)")
%---------------------PART B--------------------------------------------
%Getting the random 100 indices for the training set
train_ind = randperm(600,100);

%create the matrix, say train_X.
train_X = data(train_ind,:);
%But the above version contains all rows.
%For the X matrix, the second column is acentric factor and third col is
%Molar weight
train_y = train_X(:,6)./train_X(:,4); %Tb/Tc
train_X(:,[2,3]) = train_X(:,[5,3]);
train_X(:,[4,5,6])=[];
train_X(:,1)=1;

%The values of the coefficients
train_sol = (train_X'*train_X)\train_X'*train_y;
%Calculating the predicted boiling points:
%Equivalent to taking train_X * train_sol
train_predicted = train_X*train_sol;

%I will use sum() function to calcaulte the AAD.
%But first we need to transform each element
train_aad_term = abs(train_predicted-train_y)./train_y;
train_aad = (1/length(train_y))*sum(train_aad_term*100);
fprintf("The AAD of this experiment is: %.2f%%",train_aad);

%----------------------------Part 3 ------------------------
x = train_X(:,[2,3])';
t = train_y';
% Choose a Training Function
trainFcn = 'trainlm'; % Levenberg-Marquardt backpropagation.
% Create a Fitting Network
hiddenLayerSize = 2;
net = fitnet(hiddenLayerSize,trainFcn);
% Setup Division of Data for Training, Validation, Testing
% dividerand ensures a random division of samples
net.divideFcn = 'dividerand' ;
net.divideParam.trainRatio = 10/100;
net.divideParam.valRatio = 35/100;
net.divideParam.testRatio = 55/100;
% Train the Network
[net,tr] = train(net,x,t);

%Calculating the AAD of the ANN
ann_y = net(x);
ann_aad_term = abs(ann_y'-train_y)./train_y;
ann_aad = (1/length(train_y))*sum(ann_aad_term*100);
fprintf("\nThe AAD using ANN of this experiment is: %.2f%%",ann_aad);

