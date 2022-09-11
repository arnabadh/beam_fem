%% Material properties and other inputs
%---------------------------------------
%xivec = gauss points 
%wvec = weights 
%E = Young's Modulus of the element
%Ie = Area Moment of Inertia of the element
%q0 = Maximum distributed load (Triangular) magnitude
%L = length

E1=3.8e11;
E2=2.5e11;
Ie1=2.3*10^-8; 
Ie2=2.4*10^-8;
q0=600;q2=0; 
L=[0.46;0.38];
%no. of elements ::
nele=2;
nnode=nele+1;

%% Gauss Points and weight vector ::
% ----------------------------------
%no. of gauss points ::
ngauss=3;
%gauss points ::
xivec=[-0.774597 , 0, 0.774597];
%weights ::
wvec=[5/9, 8/9, 5/9];

%% Coordinates of Elements ::
coord=[1,0.0;%first column - node numbers
       2,0.46;%second column - coordinate
       3,0.84];
   
connect=[1,1,2;%first column - element number
         2,2,3];%second & third columns - nodes for that element
    

%% Boundary Condition data and loads and moments ::

BC_data = [1,1,0;%first column - node number
           1,2,0;%second column - prescribed local DOF; 1 for deflection
           3,1,0];                                     %2 for slope
                 %third column - value of prescribed DOF

P_load = [2 10000];%first column - node number
                   %second column - point load value

P_moment = [3 4640];%first column - node number
                     %second column - conc. moment value
uniform_flg=1;