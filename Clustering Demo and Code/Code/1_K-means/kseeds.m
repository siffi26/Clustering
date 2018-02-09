function mu = kseeds(X, k)
% Perform kmeans++ seeding

n = size(X,2);
D = inf(1,n);
mu = X(:,ceil(n*rand));
for i = 2:k
    D = min(D,sum((X-mu(:,i-1)).^2,1));
    mu(:,i) = X(:,randp(D));
end

function i = randp(p)
% Sample a integer in [1:k] with given probability p
i = find(rand<cumsum(normalize(p)),1);