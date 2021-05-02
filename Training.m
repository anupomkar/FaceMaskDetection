close all;
clear;
clc;
tic;

fprintf('\n==============================================> Simulation Started <==============================================\n');
fprintf('Start Time: %s\n', datestr(now,'HH:MM:SS.FFF\n\n'))

%layers = [
%    imageInputLayer([227 227 3],"Name","imageinput")
%    convolution2dLayer([3 3],3,"Name","conv_1","Padding","same")
%    batchNormalizationLayer("Name","batchnorm_1")
%    reluLayer("Name","relu_1")
%    maxPooling2dLayer([2 2],"Name","maxpool_1","Padding","same")
%   convolution2dLayer([3 3],3,"Name","conv_2","Padding","same")
%    batchNormalizationLayer("Name","batchnorm_2")
%    reluLayer("Name","relu_2")
%    maxPooling2dLayer([2 2],"Name","maxpool_2","Padding","same")
%    convolution2dLayer([3 3],3,"Name","conv_3","Padding","same")
%    batchNormalizationLayer("Name","batchnorm_3")
%    reluLayer("Name","relu_3")
%    fullyConnectedLayer(2,"Name","fc")
%    softmaxLayer("Name","softmax")
%    classificationLayer("Name","classoutput")
%    ];
%ins = layers(1).InputSize;



%Load Pre-trained Network (AlexNet)

alex = alexnet;
layers = alex.Layers;

%Modify Pre-trained Network

layers(23) = fullyConnectedLayer(2);
layers(25) = classificationLayer;


%Load Training Images

imds = imageDatastore('Dataset','IncludeSubfolders',true,'LabelSource','foldernames');
[trainImgs,testImgs] = splitEachLabel(imds,0.9,'randomize');
audsTrain = augmentedImageDatastore([227 227 3],trainImgs);
audsTest = augmentedImageDatastore([227 227 3],testImgs);

%Perform Transfer Learning
opts = trainingOptions('sgdm', ...
    'Plots', 'training-progress', ...
    'ValidationData',audsTest, ...
    'MaxEpochs',10, ...
    'MiniBatchSize',32, ...
    'InitialLearnRate',0.001);

net = trainNetwork(audsTrain,layers,opts);
trained_network = net;
save trained_network;

%Test Network Performance
predictedLabels = classify(net,testImages);
accuracy = mean(predictedLabels == testImages.Labels)

toc;
fprintf('End Time: %s\n', datestr(now,'HH:MM:SS.FFF'))
fprintf('\n==============================================> Simulation Ended <==============================================\n');

