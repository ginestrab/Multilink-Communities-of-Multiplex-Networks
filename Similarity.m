function [Sim,A_agg]=Similarity(A,z,epsilon)

N=max(size(A{1}));
M=numel(A);
A_agg=sparse(N,N);


for l=1:M,
   
A_agg=A_agg+A{l};
end
A_agg=A_agg>0;

[Il,Jl,Vl]=find(tril(A_agg));                       %edge list from lower diagonal A aggregate


[V,Knode]=find(sum(A_agg));                          %nodes with degree greater than 0
for nk=1:numel(Knode),
    k=Knode(nk);                                     %all links (ik,jk) incident to node k 
    [V,NeighborK]=find(A_agg(k,:));
    for ni=1:numel(NeighborK),
        i=NeighborK(ni);
        [Linkik,V]=find((Il==i).*(Jl==k)+(Il==k).*(Jl==i));
        for nj=ni+1:numel(NeighborK),
            j=NeighborK(nj);
            [Linkjk,V]=find((Il==j).*(Jl==k)+(Il==k).*(Jl==j));             
            
            Sim(Linkik,Linkjk)=Sim_Multilink(A,A_agg,M,i,j,k,z,epsilon); 
             
            Sim(Linkjk,Linkik)=Sim(Linkik,Linkjk);
        end
    end
end
Sim=sparse(Sim);
end