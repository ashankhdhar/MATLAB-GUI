function yprime = eval_y(y,mu)
%PENDODE: Holds ODE for pendulum equation.
q=2;
z=1;
p=1;
yprime = [y(1)*((q*(1-(y(1)+(y(2))+y(3)))+(z*(y(2)-y(3)))-(p*y(3))))+mu*(y(2)+y(3)-2*y(1));
y(2)*((q*(1-(y(1)+(y(2))+y(3)))+(z*(y(3)-y(1)))-(p*y(1))-(p*y(3))))+mu*(y(1)+y(3)-2*y(2));
y(3)*(q*(1-(y(1)+(y(2))+y(3)))+z*(y(1)-y(2))-(p*y(2)))+mu*(y(1)+y(2)-2*y(3))];