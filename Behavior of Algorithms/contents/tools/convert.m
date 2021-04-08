function [A] = convert(A)

A = [A;A(:,2),A(:,1)];

A = sparse(A(:,1),A(:,2),ones(length(A),1));
