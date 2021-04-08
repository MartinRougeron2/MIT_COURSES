% partial pivoting conjecture

cv = 300*[1:100];
v = zeros(1,100);

a = kahan2(25);

for i = 1:1000000,
  ap = a + randn(25)/1000;
  [l,u] = lu(ap);
  v = v + (cv < max(max(u)));
end