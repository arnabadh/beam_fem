function fe = eleload_gen(xi,q0,q2,L,x,uniform_flg)
%-----
%INPUT
%=====
%This function calculate element load vector
%q0 = Maximum distributed load(Triangular) magnitude
%L = Length
%xi = Gausspoint
%x = Nodal coordinates of the element
%------
%OUTPUT
%======
%fe = Element load vector

N1=(2-3*xi+xi^3)/4;
N2=(1-xi-xi^2+xi^3)/4;
N3=(2+3*xi-xi^3)/4;
N4=(-1-xi+xi^2+xi^3)/4;

le = x(2) - x(1);
%Hermite Shape function ::
N=[N1,le*N2/2,N3,le*N4/2];
%Lagrange shape function ::
N1x=(1-xi/2);
N2x=(1+xi/2);
xe=[N1x N2x]*x';

if uniform_flg == 1
    q = q0;
end
if uniform_flg == 0
    q = q0*(1-xe/L);
end

%if L==0.24
 %  q = q2;
%else
 %  q =( q0-((q0-q2)*xe/L));
%end
   
fe=N'*q*le/2;
