clc
clear all
close all
dataA = dlmread('datasetA.txt');
dataB = dlmread('datasetB.txt');

%[like,mu,covar,mix]=mixmodel(dataA,3,100);

[like2,mu2,covar2,mix2]=mixmodel(dataB,3,200);