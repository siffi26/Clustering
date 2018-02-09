cclear; close all;
d = 2;
k = 2;
n = 400;
% [X,label] = kmeansRnd(d,k,n);
X = dlmread('test1_data.txt'); 
X = X';
figure(1);
plot(X(1,:), X(2,:),'blueo'), xlabel('X-axis'), ylabel('Y-axis'), title('Original Data Points');
saveas(gcf,'1.jpeg');
init = ceil(k*rand(1,n));
[y,model,mse] = knKmeans(X,init,@knGauss); %Calling kernel kmeans function
plotClass(X,y)

% idx = 1:n;
% Xt = X(:,idx);
% t = knKmeansPred(model, Xt);
% plotClass(Xt,t)