
clear 
close all
load('problem2forHW4.mat')
[leng, dimension] = size(dataset);
iteration=20;
Nloop=50;
likelihood_test=zeros(iteration,5);
likelihood_train=zeros(iteration,5);
miu_all=zeros(iteration*5,5);
pai_all=zeros(iteration*5,5);

for i=1:iteration
%% split training and testing data randomly
Nrand=randperm(leng);
N = leng/2;
XTrain = dataset(Nrand(1:N),:);
XTest = dataset(Nrand(N+1:end),:);


%%
miu_=zeros(5,5);
pai_=zeros(5,5);

for K=1:5

%% initialize parameters
pai = rand(K,1);
pai=pai./sum(pai);
miu = rand(K,1);
pai_old=pai;
miu_old=miu;
t=1;
tolerance = 10^-5;

likelihood=[];
diff=1;


%% EM alogrithm

while t<=Nloop 
XX= sum(XTrain');

% E step
Tnj = repmat(pai_old, 1, N).*(repmat(miu_old,1,N).^repmat(XX, K,1)).*(repmat(1.-miu_old,1,N).^repmat(50-XX, K,1));
T = Tnj./ repmat(sum(Tnj),K,1);

% M step
miu_new = sum( T'.* repmat(XX', 1,K))./sum(T')./50;
pai_new= sum(T')./N;

%calculate the difference of miu between the two iterations
diff = sum(( miu_new' - miu_old ).^2);

%update parameters
miu_old=miu_new';
pai_old = pai_new';

t=t+1;

Tnj = repmat(pai_old, 1, N).*(repmat(miu_old,1,N).^repmat(XX, K,1)).*(repmat(1.-miu_old,1,N).^repmat(50-XX, K,1));
%cost function:
likelihood = [likelihood;sum(log(sum(Tnj)))];
end

%% plot cost function 
% if K==1
% plot(likelihood*1000)
% hold on
% else
% plot(likelihood)
% hold on   
% end
% 
miu_(K,1:K)=miu_new(:);
pai_(K,1:K)=pai_new(:);


XXt= sum(XTest');
Tnj_test = repmat(pai_old, 1, N).*(repmat(miu_old,1,N).^repmat(XXt, K,1)).*(repmat(1.-miu_old,1,N).^repmat(50-XXt, K,1));
likelihood_test(i,K) = sum(log(sum(Tnj_test)));
likelihood_train(i,K)= likelihood(Nloop);
end
miu_all((5*(i-1)+1):5*i,:)= miu_(:,:);
pai_all((5*(i-1)+1):5*i,:)= pai_(:,:);

end

likelihood_test(:,1)=likelihood_test(:,1)*1000;
likelihood_train(:,1)=likelihood_train(:,1)*1000;


%% calculate mean and std 
mean_test=round( mean(likelihood_test));
mean_train=round(mean(likelihood_train));
pai_all_3=(pai_all(3:5:end,1:3))';
pai_temp=sort(pai_all_3);
mean_pai_3=mean(pai_temp);
std_pai_3=std(pai_temp);
miu_all_3=miu_all(3:5:end,1:3);
miu_temp=sort(miu_all_3);
mean_miu_3=mean(miu_temp);
std_miu_3=std(miu_temp);
std_test= std(likelihood_test);
std_train= std(likelihood_train);

likelihood_test_int=round(likelihood_test);
likelihood_train_int=round(likelihood_train);

n=1:5;
figure
plot(n,likelihood_test(iteration,1:5),n,likelihood_train(iteration,1:5))
