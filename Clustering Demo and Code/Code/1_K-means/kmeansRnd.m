function [X, z, mu] = kmeansRnd(d, k, n)
% Generate samples from a Gaussian mixture distribution with common variances (kmeans model).

alpha = 1;
beta = nthroot(k,d); % in volume x^d there is k points: x^d=k

X = randn(d,n);
w = dirichletRnd(alpha,ones(1,k)/k);
z = discreteRnd(w,n);
E = full(sparse(z,1:n,1,k,n,n));
mu = randn(d,k)*beta;
X = X+mu*E;

function x = dirichletRnd(a, m)
% Generate samples from a Dirichlet distribution.

if nargin == 2
    a = a*m;
end
x = gamrnd(a,1);
x = x/sum(x);

function x = discreteRnd(p, n)
% Generate samples from a discrete distribution (multinomial).

if nargin == 1
    n = 1;
end
r = rand(1,n);
p = cumsum(p(:));
[~,x] = histc(r,[0;p/p(end)]);