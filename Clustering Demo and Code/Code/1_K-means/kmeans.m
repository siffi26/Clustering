function [label, mu] = kmeans(X, m)
% Perform kmeans clustering.

label = init(X, m);
n = numel(label);
idx = 1:n;
last = zeros(1,n);
j =2;
while any(label ~= last)
    [~,~,last(:)] = unique(label);                  % remove empty clusters
    
    mu = X*normalize(sparse(idx,last,1),1);         % compute cluster centers 
    mu
    [val,label] = min(dot(mu,mu,1)'/2-mu'*X,[],1);  % assign sample labels
    figure(j);
    plotClass(X, label);
    hold on;
    plot(mu(1,:),mu(2,:),'kx','MarkerSize',9,'LineWidth',3);
    xlabel('X axis');
    ylabel('Y axis');
    title('K-means Clustering');
    hold off;
    s = num2str(j);
    s = s+".jpeg";
    saveas(gcf,s);
    j = j+1;
end

function label = init(X, m)
[d,n] = size(X);
if numel(m) == 1                           % random initialization
    mu = X(:,randperm(n,m));
    [~,label] = min(dot(mu,mu,1)'/2-mu'*X,[],1); 
elseif all(size(m) == [1,n])               % init with labels
    label = m;
elseif size(m,1) == d                      % init with seeds (centers)
    [~,label] = min(dot(m,m,1)'/2-m'*X,[],1); 
end
