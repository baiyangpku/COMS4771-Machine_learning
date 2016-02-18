clear all
close all
load('hw2-2015-dataset.mat')

Xall = X;
Yall = Y;
Yall(find(Yall==0))=-1;

X= Xall(26:75, :);
Y = Yall(26:75, :);



ker = 'poly'
global p1; 


trnX = X;  trnY = Y;
tstX = [Xall(1:25, :);Xall(75:100, :)];   tstY = [Yall(1:25, :);Yall(75:100, :)];
N=13;M=20;

nsv=zeros(N,M);
err=zeros(N,M);

for i=1:N
    for j=1:M 
        p1=i;
        C =0.01*M;
        [nsv(i,j), alpha, b0] = svc(X,Y,ker,C);
        bias= b0;
        err(i,j) = svcerror(trnX,trnY,tstX,tstY,ker,alpha,bias);
    end
end

xa=1:N;
ya=0.01*(1:M);
figure 
surf(ya,xa,err)

