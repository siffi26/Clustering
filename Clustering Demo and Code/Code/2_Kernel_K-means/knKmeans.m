function [label, model, energy] = knKmeans(X, init, kn)
% Perform kernel kmeans clustering.

n = size(X,2);
if numel(init)==1
    k = init;
    label = ceil(k*rand(1,n));
elseif numel(init)==n
    label = init;
end
if nargin < 3
    kn = @knGauss;
end
K = kn(X,X);
last = zeros(1,n);
j =2;
while any(label ~= last)
    [~,~,last(:)] = unique(label);   % remove empty clusters
    E = sparse(last,1:n,1);
    E = E./sum(E,2);
    T = E*K;
    [val, label] = max(T-dot(T,E,2)/2,[],1);
    figure(j);
    mu = plotClass(X, label);
    hold on;
%     [a,b] = size(label)
    
    plot(mu(:,1),mu(:,2),'kx','MarkerSize',9,'LineWidth',3);

    xlabel('X axis');
    ylabel('Y axis');
    title('Kernel K-means Clustering');
    hold off;
    s = num2str(j);
    s = s+".jpeg";
    saveas(gcf,s);
    j = j+1;
end
energy = trace(K)-2*sum(val); 
if nargout == 3
    model.X = X;
    model.label = label;
    model.kn = kn;
end