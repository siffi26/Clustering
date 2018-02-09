function Y = normalize(X, dim)
% Normalize the vectors to be summing to one
if nargin == 1
    % Determine which dimension sum will use
    dim = find(size(X)~=1,1);
    if isempty(dim), dim = 1; end
end
Y = X./sum(X,dim);  % Normalize the vectors 