function E = crossedGrid(D,flag)
% function E = crossedGrid(D,flag)
% 
% generate edge list of an n-by-n grid graph with
% each cell crossed according to whether D is 0 or 1
%
% if flag is set, display it as well
%
% ex: E = crossedGrid((randn(10)<1/2), 1)

if (nargin < 2),
  flag = 0;
end

E = [];

n = length(D)+1;

% horizontal edges
for y = 0:(n-1),
  for x = 0:(n-2)
    E = [E ; [cellToNum(n,x,y), cellToNum(n,x+1,y)]];
  end
end

% vertical edges
for x = 0:(n-1),
  for y = 0:(n-2)
    E = [E ; [cellToNum(n,x,y), cellToNum(n,x,y+1)]];
  end
end

% cross edges
for x = 0:(n-2),
  for y = 0:(n-2),
    if (D(x+1,y+1) == 1)
       E = [E ; [cellToNum(n,x,y), cellToNum(n,x+1,y+1)]];
    else
       E = [E ; [cellToNum(n,x+1,y), cellToNum(n,x,y+1)]];
    end
  end
end


if (flag == 1),
  clf;
  hold on;
  for i = 1:length(E),
    plotEdge(n,E(i,:));
  end
end



function a = cellToNum(n,x,y)
  a = n*y + x + 1;

function [x,y] = numToCell(n,a)
  a = a - 1;
  x = mod(a,n);
  y = (a - x)/n;

function plotEdge(n,e)
  [x1,y1] = numToCell(n,e(1));
  [x2,y2] = numToCell(n,e(2));
  plot([x1 x2],[y1 y2]);


