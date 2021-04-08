function [x,lambda] = fastfiedler(G,k);
% FASTFIEDLER : Fiedler vector of a graph.
%
% x = fastfiedler(G)  returns the eigenvector corresponding to 
%                 the second-smallest eigenvalue of the laplacian matrix 
%                 of the graph whose adjacency matrix is G|G'.
%                 (If G is connected this is the smallest positive eval.)
% [x,lambda] = fastfiedler(G)  also returns the eigenvalue.
% [x,lambda] = fastfiedler(G,k) returns the k smallest nonzero eigenvalues
%                 and their eigenvectors.
%
% If G is full or smaller than 100 vertices we use Matlab's full "eig";
% if G is sparse we use an iterative method.
%
% See also LAPLACIAN, SPECPARTITION, FIEDLER.
%
% John Gilbert  2 February 1994
% Copyright (c) 1993-1994 by Xerox Corporation.  All rights reserved.

if nargin < 2
    k = 1;
end;

[n,n] = size(G);
if n < 100, 
    G = full(G); 
end;
L = laplacian(G);

%L(1,1) = L(1,1) - 2;
%L(3,3) = L(3,3) +2;

%for i = 1:length(L),
% for j = 1: i-1,
%   L(i,j) = - L(i,j);
% end;
% end;

%L(8,8) = L(8,8) - 10
%L(1,1) = L(1,1) -2
%L(2,2) = L(2,2) -2

%for i = 1: length(L),
%   L(i,i) = 0;
%end


if issparse(G)
    % Sparse graph -- use iteration.
    x = ones(n,1)/sqrt(n);
    lambda = 1;
    shift = -eps^.25;
    I = speye(n);
    p = symmmd(L);
    L = L(p,p);
    R = chol(L-shift*I);
    Rt = R';
    for j = 1:k
        vector = j;
        % Append the j+1'st eigenvector to x.
    
        % Use a few power iterations with a small negative shift first.
        y = rand(n,1);
        y = y - x*(x'*y);
        for i = 1:20*j
             preiteration = i;
             y = R\(Rt\y);
             estimate = 1/norm(y) + shift;
             y = y - x*(x'*y);
             y = y/norm(y);
        end;

        % Now use Rayleigh quotient iteration with a variable shift.
        tol = eps^.25;
        maxiter = 10;
        iteration = 0;
        done = 0;
        while ~done,
            iteration = iteration+1;
            % Get shift as Rayleigh quotient
            estimate = y'*L*y;
            % Get new y by inverse iteration with Rayleigh shift
            newy = (L - estimate*I) \ y;
            newy = newy/norm(newy);
            % Test for convergence
            measure = norm(newy-y)*norm(newy+y);
            done = measure < tol;
            y = newy;
            % Project y to be orthogonal to earlier eigenvectors.
            y = y - x*(x'*y);
            y = y/norm(y);
            if iteration == maxiter
                done = 1;
%                disp('Rayleigh iteration reached maxiter.');
            end
        end;
        x = [x y];
        lambda = [lambda estimate];
    end;
    x = x(:,2:k+1);
    x(p,:) = x;
    lambda = lambda(2:k+1);

else

    % Full graph -- just use eig.
    [V,D] = eig(L);
    [d,i] = sort(diag(D));
    lambda = d(2:k+1);
    x = V(:,i(2:k+1));

end;

