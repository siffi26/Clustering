clc; close all; clear;
% d = 2;
% k = 3;
% n = 400;
% [data,label] = kmeansRnd(d,k,n);
data = dlmread('test1_data.txt');
% label = dlmread('test2_ground.txt');
% ll = ones(400,1);
% label = label + ll;
% plotClass(data', label');
% figure(1),plot(data(1,:), data(2,:),'greeno'), xlabel('X-axis'), ylabel('Y-axis'), title('Original Data Points');
figure(1);
plot(data(:,1), data(:,2),'greeno'), xlabel('X-axis'), ylabel('Y-axis'), title('Original Data Points');

grid on;shg
hold on;
data = data';

m=2; 
mu = kseeds(data, m);
mu
plot(mu(1,:),mu(2,:),'kx','MarkerSize',9,'LineWidth',3);
saveas(gcf,'1.jpeg');
[label, mu, energy] = kmeans(data, m);


