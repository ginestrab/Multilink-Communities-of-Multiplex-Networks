function [simlink]=Sim_Multiink(A,A_agg,M,i,j,k,z,epsilon)

N=max(size(A{1}));
xi=zeros(1,M);
xj=zeros(1,M);
xij=zeros(1,M);
kaus=1;
for l=1:M
    ki=sum(A{l}(i,:))-A{l}(i,k);
    kj=sum(A{l}(j,:))-A{l}(j,k);
    kaus=kaus-A{l}(i,k)*A{l}(j,k)/M;
    xi(l)=ki/(N-2);
    xj(l)=kj/(N-2);
    for nrun=1:5,
        xi(l)=ki/((N-2)/(1+xi(l))+(xi(l))/(1+xi(l)*xj(l)));
        xj(l)=kj/((N-2)/(1+xj(l))+(xj(l))/(1+xi(l)*xj(l)));
    end

    xij(l)=xi(l)*xj(l)/(1+xi(l)*xj(l));

end

a_neighbors=A_agg(i,:).*A_agg(j,:);
a_neighbors(i)=0;
a_neighbors(j)=0;
a_neighbors(k)=0;
ki1=sum(A_agg(i,:));
kj1=sum(A_agg(j,:));
L=min(ki1,kj1)-1;

[V,ij_neighbors]=find(a_neighbors);


simlink=epsilon*z^(kaus);

for n1=1:numel(ij_neighbors),
    ell=ij_neighbors(n1);
    aus=1;
    p_ij_ell=1;
    for l=1:M,
        p_ij_ell=p_ij_ell*((xi(l)/(1+xi(l)))*A{l}(i,ell)+(1-xi(l)/(1+xi(l)))*(1-A{l}(i,ell)));
        p_ij_ell=p_ij_ell*((xj(l)/(1+xj(l)))*A{l}(j,ell)+(1-xj(l)/(1+xj(l)))*(1-A{l}(j,ell)));
        aus=aus-A{l}(i,ell)*A{l}(j,ell)/M;
    end
    
        simlink=simlink+(1-epsilon)*z^(aus)*(1-p_ij_ell)/L;
end
    if(A_agg(i,j)>0)
        aus=1;
        p_ij_ell=1;
        for l=1:M,
        p_ij_ell=p_ij_ell*(xij(l)*A{l}(i,j)+(1-xij(l))*(1-A{l}(i,j)));
         aus=aus-A{l}(i,j)/M;
        end
        simlink=simlink+(1-epsilon)*z^(aus)*(1-p_ij_ell)/L;
    end
    
end
