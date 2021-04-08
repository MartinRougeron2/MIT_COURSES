function art3(E,x,y,z)


figure(1)
hold on
clf
plot3(x,y,z,'o');
hold on
for i = 1:length(E)
  plot3(x(E(i,:))',y(E(i,:))',z(E(i,:))');
end

for i = 1:length(x),
  text(x(i),y(i),z(i),num2str(i));
end
