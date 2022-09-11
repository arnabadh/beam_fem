function [xnume,unume] = postprocessing(nele,coord,connect,un,xi)
%This function calculate variable u at different distributed point
%element from nodal values of u
%-----
%INPUT
%=====
%nele = no. of elements
%coord = Nodal coordinates %first column - node numbers
                           %second column - coordinate
%connect = Nodal Connectivities %first column - element number
                                %second & third columns - nodes for that element
                                %for that element
%xi = points distributed for an element in master dommain
%un = nodal values of u

xnume=[];unume=[];
    for el=1:nele
        
        nd1=connect(el,2);
        nd2=connect(el,3);
        x_n=[coord(nd1,2),coord(nd2,2)];%1x2 vector
        vec=[2*nd1-1 , 2*nd1, 2*nd2-1, 2*nd2];%Global DOF corresponding to nodes
        u_n=un(vec);
        
        le=x_n(2)-x_n(1);
        Nx=[(1-xi)/2,(1+xi)/2];%11x2 matrix
    
        N1=(2-3*xi+xi.^3)/4;
        N2=(1-xi-xi.^2+xi.^3)/4;
        N3=(2+3*xi-xi.^3)/4;
        N4=(-1-xi+xi.^2+xi.^3)/4;
        Nu=[N1,le*N2/2,N3,le*N4/2];
        
        xnume=[xnume;Nx*x_n'];
        unume=[unume;Nu*u_n];
    end
end