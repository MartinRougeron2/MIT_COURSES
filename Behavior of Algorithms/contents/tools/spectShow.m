% script spectShow
%
% demonstrations of spectral embeddings of graphs
%
% Daniel A. Spielman, 2002
% Copyright (c) 1993-1994 by MIT.  All rights reserved.


%% eppstein's mesh

load EppBAP.mat
who
figure(1);
clf
gplot(A,xy)

L = diag(sum(A)) - A;
[v,d] = eigs(L,3,0);

pause

figure(2);
clf
gplot(A,v(:,1:2))

pause

%% chew circle

load chew_circle
figure(1);
gplot(A,xy)

pause

figure(2);
gplot(A,v(:,1:2))

pause

%% mcrack

load mcrack
figure(1);
gplot(A,xy)

pause

figure(2);
gplot(A,v(:,1:2))

pause

%% airfoil

load airfoil1

figure(1);
gplot(A,xy)

pause

figure(2);
gplot(A,v(:,1:2))

pause



%% a grid graph

load grid5by7
A = graph2A(grid5by7)

[x,y] = meshgrid(1:7,1:5);
xy = [x(:) y(:)];

figure(1);
gplot(A,xy)

pause

figure(2)
L = diag(sum(A)) - A + eye(length(A));
[v,d] = eigs(L,3,0);
gplot(A,v(:,1:2))

pause

%% another grid graph

load grid3by20
A = graph2A(grid3by20)

[x,y] = meshgrid(1:20,1:3);
xy = [x(:) y(:)];

figure(1);
gplot(A,xy);

pause

L = diag(sum(A)) - A + eye(length(A));
[v,d] = eigs(L,3,0);

figure(2);
gplot(A,v(:,1:2))

pause

%% docec

close(2)
load dodec
A = graph2A(dodec);

L = diag(sum(A)) - A;

[v,d] = eigs(L,4,0);
art3(dodec,v(:,1),v(:,2),v(:,3));


pause

%% my other graphs

spectShow1
