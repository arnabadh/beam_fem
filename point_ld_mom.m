function F = point_ld_mom(F,P_load,P_moment)
%This function update Global load vector after incorporating point load
%and conc. moment data
%-----
%INPUT
%=====
%F = Global load vector before implementing point load and point moment
%P_load = Point load data %first column - node number
                          %second column - point load value
%P_moment = Point moment data %first column - node number
                              %second column - conc. moment value
%------
%OUTPUT
%======
%F = Global load vector before implementing point load and point moment
%% External Point Load and Moment ::
for ii = 1,size(P_load,1)%size(P_load,1) signifies no. of rows of P_load
    nd = P_load(ii,1);
    F0 = P_load(ii,2);
    F(2*nd-1) = F(2*nd-1) + F0;
end

for ii = 1,size(P_moment,1)%size(P_moment,1) signifies no. of rows of P_moment
    nd = P_moment(ii,1);
    M0 = P_moment(ii,2);
    F(2*nd-1) = F(2*nd-1) + M0;
end

end