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

%Actual ANN calculations
step_size = 0.02;
train_ratios = 0.05:step_size:0.475;
test_ratios = 0.05:step_size:0.475;
x = train_X(:,[2,3])';
t = train_y';

% Choose a Training Function
trainFcn = 'trainlm'; % Levenberg-Marquardt backpropagation.
% Create a Fitting Network
hiddenLayerSize = 2;

counter = 1; %For the matrix.
%A general matrix, named aad_matrix, will contain train and test ratio
%along with its AAD value
for train_ratio = train_ratios
    for test_ratio = test_ratios
        net = fitnet(hiddenLayerSize,trainFcn);
        % Setup Division of Data for Training, Validation, Testing
        % dividerand ensures a random division of samples
        net.divideFcn = 'dividerand' ;
        net.divideParam.trainRatio = train_ratio;
        net.divideParam.valRatio = test_ratio;
        net.divideParam.testRatio = 1-train_ratio-test_ratio;
        % Train the Network
        [net,tr] = train(net,x,t);
        
        %Calculating the AAD of the ANN
        ann_y = net(x);
        ann_aad_term = abs(ann_y'-train_y)./train_y;
        ann_aad = (1/length(train_y))*sum(ann_aad_term*100);
        %Putting the value into the general matrix
        aad_matrix(counter,1:3)=[train_ratio,test_ratio,ann_aad];
        clear net
        counter = counter+1;
    end
end
x = aad_matrix(:,1);
y = aad_matrix(:,2);
z = aad_matrix(:,3);

plot3(x,y,z,'o')
%The below few lines are done to make the scatter plot a surface plot
[xq,yq] = meshgrid(-0.1:.001:1, 0:.001:1);
vq = griddata(x,y,z,xq,yq); 
mesh(xq,yq,vq)
hold on
plot3(x,y,z,'o')
%---------------------------^^^^^^----------------------------------------
xlabel("train ratios")
ylabel("Test Labels")
zlabel("AAD")