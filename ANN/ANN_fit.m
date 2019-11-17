clear;clc;
Basic_I=0.5:0.5:15;
Basic_Time=(0:0.02/120:0.02-0.02/120)';
[X,Y]=ndgrid(Basic_I,Basic_Time);
input=[X(:),Y(:)];
load('Basic_Fun_FP.mat');
for j=1:size(Basic_Fun{1}.rad,2)
    for i=1:length(Basic_Fun)
        temp{j}.rad(i,:)=Basic_Fun{i}.rad(:,j);
        temp{j}.tan(i,:)=Basic_Fun{i}.tan(:,j);
    end
    output.rad(:,j)=reshape(temp{j}.rad,[3600,1]);
    output.tan(:,j)=reshape(temp{j}.tan,[3600,1]);
end
% 随机排序
k=rand(1,size(input,1));
[m,n]=sort(k);
% 分类训练数据和预测数据
input_train=input(n(1:3500),:)';
input_test=input(n(3501:3600),:)';
output_train.rad=output.rad(n(1:3500),:)';
output_test.rad=output.rad(n(3501:3600),:)';
output_train.tan=output.tan(n(1:3500),:)';
output_test.tan=output.tan(n(3501:3600),:)';
% 训练数据归一化
[inputn,inputps]=mapminmax(input_train,-1,1);
inputn_test=mapminmax('apply',input_test,inputps,-1,1);
% 训练神经网络
for i=1:size(output_train.rad,1)
    ANN.rad{i}=feedforwardnet(25,'trainlm');
    ANN.tan{i}=feedforwardnet(25,'trainlm');
%     net{i}.trainparam.epochs=1000;
    [outputn.rad,outputps.rad]=mapminmax(output_train.rad(i,:),-1,1);
    [outputn.tan,outputps.tan]=mapminmax(output_train.tan(i,:),-1,1);
    ANN.rad{i}=train(ANN.rad{i},inputn,outputn.rad);
    ANN.tan{i}=train(ANN.tan{i},inputn,outputn.tan);
    Temp.rad(i,:)=sim(ANN.rad{i},inputn_test);
    Temp.tan(i,:)=sim(ANN.tan{i},inputn_test);
    Barm.rad(i,:)=mapminmax('reverse',Temp.rad(i,:),outputps.rad,-1,1);
    Barm.tan(i,:)=mapminmax('reverse',Temp.tan(i,:),outputps.tan,-1,1);
end
