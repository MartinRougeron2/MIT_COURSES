function [A] = graph2A(E)

% GRAPH2A [A] = graph2A(E)
%	computes the sparse representation of a graph whose edges are E
%	    where
%	E is an e by 2 matrix
%
% makes sure A is symmetric
%
% Dan Spielman and Shanghua Teng, 1996
% Copyright (c) UC Berkeley/MIT/UMN.  All rights reserved.

i = E(:,1);
j = E(:,2);

ii = [i;j];
jj = [j;i];

s = ones(size(ii));

A = sparse(ii,jj,s);

%A = sparse(i,j,s);

A = (A + A') > 0;
