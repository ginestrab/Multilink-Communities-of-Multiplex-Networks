b=load('Padgett-Florentine-Families_multiplex.edges');
M=max(b(:,1));
N=max(max(b(:,2)),max(b(:,3)));
for n=1:M,
    A{n}=zeros(N,N);
end
for n=1:max(size(b)),
    A{b(n,1)}(b(n,2),b(n,3))=1;
    A{b(n,1)}(b(n,3),b(n,2))=1;
end

