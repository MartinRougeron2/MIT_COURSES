function A = kahan(n)
% function A = kahan(n)
%

A = tril(-ones(n)) + 2*eye(n);
A(:,n) = 1;
