
clc;
clear all;
close all;

% generate the data
% data = kmeansRnd(2, 2, 500)
% data = data';
data = dlmread('test1_data.txt'); 
data = data;
figure(1),plot(data(:,1), data(:,2),'bo'), title('Original Data Points'); 
saveas(gcf, '1.jpeg');
grid on;shg
hold on;

% calculate the affinity / similarity matrix (W)
affinity = CalculateAffinity(data);
% figure,imshow(affinity,[]), title('Affinity Matrix')

% compute the degree matrix (D)
for i=1:size(affinity,1)
    D(i,i) = sum(affinity(i,:));
end

% compute the normalized laplacian / affinity matrix (method 1)
%NL1 = D^(-1/2) .* L .* D^(-1/2);
for i=1:size(affinity,1)
    for j=1:size(affinity,2)
        NL1(i,j) = affinity(i,j) / (sqrt(D(i,i)) * sqrt(D(j,j)));  
    end
end

% compute the normalized laplacian (method 2)  eye command is used to
% obtain the identity matrix of size m x n
% NL2 = eye(size(affinity,1),size(affinity,2)) - (D^(-1/2) .* affinity .* D^(-1/2));

% perform the eigen value decomposition
[eigVectors,eigValues] = eig(NL1);

% select k largest eigen vectors
k = 4;
nEigVec = eigVectors(:,(size(eigVectors,1)-(k-1)): size(eigVectors,1));

% construct the normalized matrix U from the obtained eigen vectors
for i=1:size(nEigVec,1)
    n = sqrt(sum(nEigVec(i,:).^2));    
    U(i,:) = nEigVec(i,:) ./ n; 
end
% perform kmeans clustering on the matrix U
[IDX,C] = kmeans(U',3);
IDX = IDX';

% plot the eigen vector corresponding to the largest eigen value
%figure,plot(IDX)
figure,
hold on;
for i=1:size(IDX,1)
    if IDX(i,1) == 1
        plot(data(i,1),data(i,2),'bo');
    elseif IDX(i,1) == 2
        plot(data(i,1),data(i,2),'ro');
    elseif IDX(i,1) == 3
        plot(data(i,1),data(i,2),'go');
    else
        plot(data(i,1),data(i,2),'yo');        
    end
end
saveas(gcf, 'final.jpeg');
hold off;
title('Clustering Result using Spectral Clustering');
grid on;shg