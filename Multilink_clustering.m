
%++++++++ Multilink Clustering  ++++++++++++++++++++++++++++++++++++++++++++
% 
% This code can be redistributed and/or modified
% under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or (at
% your option) any later version.
%  
% This program is distributed ny the authors in the hope that it will be 
% useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%
%  
% If you use this code please cite 
%
% [1]   R.J. Mondragon, J.Iacovacci,  and G. Bianconi, 
%"Multilinks Communities of  Multiplex Networks"
%  (2017).
%
% (c) 
%     Ginestra Bianconi (g.bianconi@qmul.ac.uk) 
%     Raul J. Mondragon (r.j.mondragon@qmul.ac.uk)
%     Jacopo Iacovacci  (j. iacovacci@qmul.ac.uk)
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



function [links,multilink_communities,Z,K_partition]=Multilink_clustering(A,z,epsilon,options_figure)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following program takes in input:

%1. a cell A of M sparse undirected adjacency matrices (ordered layers of the multiplex network)
%   ex. A{1} is a N times N adjacency matrix of layer 1
%2. the z parameter of the Multilink Community Detection algorithm
%3. the epsilon parameter of the Multilink Community Detection algorithm
%4. an optional parameter for printing figures on the scorefunction
%profile (link modularity, the dendrogram and the similarity matrix)

%It produces as an output:

%1. edge list in the form of array links having each element equal to the
%   pair of nodes connected.
% The n-th multilink is indicated by the couple of values
% links(n,1) indicating the first node of the multilink 
% links(n,2) indicating the second node of the multilink

%2. mutlilinks_community is an array attributing to each multilink a community
% link_community(n) gives the community of the n-th multilinks
%3. Z dendrogram
%4. K_partition optimal cut of the dendrogram

[Sim,A_agg]=Similarity(A,z,epsilon);
[Il,Jl,Vl]=find(tril(A_agg));
links=[Il,Jl];

ii=0;
for i=1:size(Sim,1)-1
    for j=i+1:size(Sim,1)
    if(i~=j)   
    ii=ii+1;
       D(ii)=1-Sim(i,j);
    end
    end    
end

Z=linkage(D,'single');
max_clusters=max(size(Sim));
Max_ScFun=0;

ScFun=zeros(1,max_clusters);
for nclusters=1:max_clusters,
c = cluster(Z,'maxclust',nclusters);
ScFun(nclusters)=ScoreLinkModularity(A,A_agg,c);
if(Max_ScFun<ScFun(nclusters))
    Max_ScFun=ScFun(nclusters);
    K_partition=nclusters;
end
end

t=sort(Z(:,3));
th2=t(size(Z,1)+2-K_partition);
multilink_communities=cluster(Z,'maxclust',K_partition);
order=optimalleaforder(Z,D);


if (options_figure==1)

%figure score 
figure;
hold on;
plot(ScFun,'--sr','Linewidth',1.5);
xlabel('# clusters')
ylabel('Score Function')



%figure dendro
figure;dendrogram(Z,0,'Reorder',order,'ColorThreshold',th2)


%figure similarity matrix
dg=ones(size(Sim,1),1);
figure;
imagesc(Sim(order,order)+diag(dg));colormap('parula');colorbar;
ylabel(colorbar,'Multilink Similarity','FontSize', 16);
end

end