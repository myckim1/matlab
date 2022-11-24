clear;clc;close all
[data,text,~] = xlsread("BoilingPointData.xlsx");

train_ind = randperm(600,100);
%------------Preparing the data-------------------------------------------
%create the matrix, say train_X.
train_X = data(train_ind,:);
%But the above version contains all rows.
%For the X matrix, the second column is acentric factor and third col is
%Molar weight
train_y = train_X(:,6)./train_X(:,4); %Tb/Tc
train_X(:,[2,3]) = train_X(:,[5,3]);
train_X(:,[4,5,6])=[];
train_X(:,1)=1;

trainFcn = 'trainlm';
x = train_X(:,[2,3])';
t = train_y';
for layers = 1:1:30
    net = fitnet(layers,trainFcn);
    % Setup Division of Data for Training, Validation, Testing
    % dividerand ensures a random division of samples
    net.divideFcn = 'dividerand' ;
    net.divideParam.trainRatio = 60/100;
    net.divideParam.valRatio = 20/100;
    net.divideParam.testRatio = 20/100;
    % Train the Network
    [net,tr] = train(net,x,t);
    
    %Calculating the AAD of the ANN
    ann_y = net(x);
    ann_aad_term = abs(ann_y'-train_y)./train_y;
    ann_aad = (1/length(train_y))*sum(ann_aad_term*100);
    aad_matrix(layers,[1 2]) = [layers ann_aad];
    clear net
end
plot(aad_matrix(:,2),'-o')
xlabel("Number of Hidden Layers")
ylabel("AAD")