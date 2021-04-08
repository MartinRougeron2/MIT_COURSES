function [l,u] = gauss(A)
% function [l,u] = gauss(A)

n = size(A);

u = A;
l = eye(n);


for i = 1:(n-1),
 l((i+1):n,i) = u((i+1):n,i)/u(i,i);
 u((i+1):n,:) = u((i+1):n,:) - u((i+1):n,i)*u(i,:)/u(i,i);
end
