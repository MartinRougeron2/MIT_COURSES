function A = kahan2(n)
% function A = kahan2(n)
%

A = tril(-.9*ones(n)) + 2*eye(n);
A(:,n) = 1;
