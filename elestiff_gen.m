function ke = elestiff_gen(xi,E,Ie,x)
%This function calculate element Stiffness Matrix
%-----
%INPUT
%=====
%E = Young's Modulus of the element
%Ie = Area Moment of Inertia of the element
%xi = Gausspoint
%x = Nodal coordinates of the element
%------
%OUTPUT
%======
%ke = Element stiffness matrix

Le=x(2)-x(1);

B1=3*xi/2;
B2=Le*(3*xi-1)/4;
B3=-3*xi/2;
B4=Le*(3*xi+1)/4;

B=(4/Le^2)*[B1,B2,B3,B4];

ke=(E*Ie*Le/2)*(B'*B);