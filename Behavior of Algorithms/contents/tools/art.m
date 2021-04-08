function [xA,lambda,A] = art(A,number,number1,k)
% function [xA,lambda,A] = art(A,number,number1,k)

keepA = A;

if nargin < 4,
  k = max(max(A)) -1;
end;

A = convert(A);
[xA,lambda] = fastfiedler(A,k); 

figure(1)
hold off
clf
gplot(A,xA(:,1:2));

if number == 1, 
  for i = 1:length(xA),
    text(xA(i,1),xA(i,2),num2str(i));
  end
end


figure(2)
hold off
clf

gplot(A,xA(:,k-1:k));

if number1 == 1, 
  for i = 1:length(xA),
    text(xA(i,k-1),xA(i,k),num2str(i));
  end
end

%[list] = report(keepA,xA(:,k-1),xA(:,k));

