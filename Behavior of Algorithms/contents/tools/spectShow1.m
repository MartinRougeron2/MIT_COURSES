% script spectShow1
%
% demonstrations of spectral embeddings of graphs
%
% Daniel A. Spielman, 2002
% Copyright (c) 1993-1994 by MIT.  All rights reserved.


a = (rand(10) < 1/2);
E = crossedGrid(a,0);
A = graph2A(E);
prevV = zeros(size(A,1),3);

for i = 1:1000,
x = ceil(10*rand(1));
y = ceil(10*rand(1));
a(x,y) = 1 - a(x,y);
figure(2);
E = crossedGrid(a,1);
A = graph2A(E);
L = diag(sum(A)) - A + diag(ones(1,size(A,1)));
[v,d] = eigs(L,3,'SM');


% try to set signs so looks like prev one
if ((v(:,1)' * prevV(:,1)) < (-v(:,1)' * prevV(:,1)))
    v(:,1) = -v(:,1);
end

% try to set signs so looks like prev one
if ((v(:,2)' * prevV(:,2)) < (-v(:,2)' * prevV(:,2)))
    v(:,2) = -v(:,2);
end

%[jnk,ind] = max(abs(v(:,1)))
%v(:,1) = v(:,1) * sign(v(1,1));

%[jnk,ind] = max(abs(v(:,2)))
%v(:,2) = v(:,2) * sign(v(1,2));

prevV = v;


figure(1);

clf
gplot(A,v(:,1:2)); hold on;
plot(v(1,1),v(1,2),'ro');

axis(1.1*[min(v(:,1)) max(v(:,1)) min(v(:,2)) max(v(:,2))]);
pause(.5);
end