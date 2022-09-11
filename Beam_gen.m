%===================
%Reading input file
%===================
inputfile;
%% Global Stiffness Matrix and Global load vector
%-----------------------
%This function calculate Global Stiffness matrix and
% Global load vector due to distributed load

[K,F] = stiff_load(nele,ngauss,coord,connect,xivec,wvec,E1,E2,Ie1,Ie2,q0,q2,L,uniform_flg);

%% Point load and Point moment
%----------------------------
%This function update Global load vector after incorporating point load
%and conc. moment data  

F = point_ld_mom(F,P_load,P_moment);

%% Imposition of B.C. ::
K_glob = K;
F_glob = F;

%This function update Global stiffness matrix and load vector
%after incorporating Boundary condition data

[K,F]=impose_bc(K,F,BC_data,nnode);


%% Finding solution ::
ureduce=(K)\F;

%% Finding Rxn Force ::
un=[0;0;ureduce;0];
Freac=K_glob*un;

%% Post Processing :FEM displcement ::
xi= [-1:0.2:1]';%intermediate gauss points, 11x1 vector
%This function calculate variable u at different distributed point
%element from nodal values of u
[xnume,unume] = postprocessing(nele,coord,connect,un,xi);

    
    

        
