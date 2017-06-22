function MSF=Score_LinkModularity(A,A_agg,c)
MSF=0;
nclusters=max(c);
N=max(size(A{1}));
M=numel(A);

[Il,Jl,Vl]=find(tril(A_agg));
B=zeros(numel(Vl),N);
for el=1:numel(Vl),
    B(el,Il(el))=1;
    B(el,Jl(el))=1;
end

C=B*(B');
C=C-diag(diag(C));
kl=sum(C,1);
W=sum(kl);

for k=1:nclusters,
    [nlink,V]=find(c==k);     
        for i=1:numel(nlink),
            for j=i+1:numel(nlink),
                MSF=MSF+2*(C(nlink(i),nlink(j))-kl(nlink(i))*kl(nlink(j))/(W))/W;
            end
        end
end

end