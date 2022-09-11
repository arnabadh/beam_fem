function [K,F] = stiff_load(nele,ngauss,coord,connect,xivec,wvec,E1,E2,Ie1,Ie2,q0,q2,L,uniform_flg)
%This function calculate Global Stiffness matrix and
% Global load vector due to distributed load
%-----
%INPUT
%=====
%nele = No. of elements
%ngauss = No. of gauss points for integration
%coord = Nodal coordinates %first column - node numbers
                           %second column - coordinate
%connect = Nodal Connectivities %first column - element number
                                %second & third columns - nodes for that element
                                %for that element
%xivec = gauss points 
%wvec = weights 
%E = Young's Modulus of the element
%Ie = Area Moment of Inertia of the element
%q0 = Maximum distributed load (Triangular) magnitude
%L = length
%
%------
%OUTPUT
%======
%K = Global stiffness matrix
%F = Global load vector

nnode=nele+1;%No of nodes
K=zeros(2*nnode,2*nnode);
F=zeros(2*nnode,1);
%% calculation of element stiffness matrix and element load vector & Assembly using connectivity data ::
%loop over elements ::
for el=1:nele

    nd1=connect(el,2);
    nd2=connect(el,3);
    x=[coord(nd1,2),coord(nd2,2)];
    %Global DOF ::
    vec=[2*nd1-1,2*nd1,2*nd2-1,2*nd2];

    kele=zeros(4,4);%size of element stiffness matrix for beam element is 4x4
    fele=zeros(4,1);

    %loop over gauss points ::    
        for gp=1:ngauss
            xi=xivec(gp) ; w=wvec(gp);
            %calculation of element stiffness matrix ::
            if el == 1
                kele(1:4,1:4)=kele(1:4,1:4)+ elestiff_gen(xi,E1,Ie1,x)*w;
            end
            if el == 2
                kele(1:4,1:4)=kele(1:4,1:4)+ elestiff_gen(xi,E2,Ie2,x)*w;
            end
            %calculation of element load vector ::
            fele(1:4)=fele(1:4)+ eleload_gen(xi,q0,q2,L(el),x,uniform_flg)*w;
        end

        %Assembly using connectivity ::
        for ii=1:4
            for jj =1:4
                %assembly of stiffness matrix ::
                K(vec(ii),vec(jj))=K(vec(ii),vec(jj)) + kele(ii,jj);
            end
            %assembly of load vector ::
            F(vec(ii))=F(vec(ii))+fele(ii);
        end
end

end