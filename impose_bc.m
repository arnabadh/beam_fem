function [K,F]=impose_bc(K,F,BC_data,nnode)
%This function update Global stiffness matrix and load vector
%after incorporating Boundary condition data
%-----
%INPUT
%=====
%K = Global stiffness matrix before implementing Boundary Conditions
%F = Global load vector before implementing Boundary Conditions
%BC_data = Boundary condition data %first column - node number
                                   %second column - prescribed local DOF; 1 for deflection
                                                                         %2 for slope
                                   %third column - value of prescribed DOF
%------
%OUTPUT
%======
%K = Global stiffness matrix after implementing Boundary Conditions
%F = Global load vector after implementing Boundary Conditions

%it is those DOF which are eliminated in reduced stiffness matrix ::
supp_dof=[];

%Modification of Load vector due to nonzero value ::
for ii = 1:size(BC_data,1)
    nd = BC_data(ii,1);
    local_dof = BC_data(ii,2);
    val = BC_data(ii,3);
    GDOF=2*(nd-1) + local_dof;
    supp_dof=[supp_dof,GDOF];
    if(val~=0)
        for jj =1:2*nnode
            F(jj)=F(jj)- K(jj,GDOF)*val;
        end
    end
end

%Elimination of row and column of stiffness matrix and
%         of row of the load vector
supp_dof=sort(supp_dof);
for ii =1:size(supp_dof,2)%size(supp_dof,2) signifies no. of columns of P_load
    dof = supp_dof(ii);
    if dof == 1
        K = K(dof+1:end,dof+1:end);
        F = F(dof+1:end);
    elseif dof == 2*nnode
        K = K(1:dof-1,1:dof-1);
        F = F(1:dof-1);
    else
        K = K([1:dof-1,dof+1:end],[1:dof-1,dof+1:end]);
        F = F([1:dof-1,dof+1:end]);
    end

    if(ii~=size(supp_dof,2))%size(supp_dof,2) signifies no. of columns of P_load
        supp_dof(ii+1:end)=supp_dof(ii+1:end)-1;
    end
end

end