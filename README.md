# Multilink-Communities-of-Multiplex-Networks


This repository contains: 

1) Multilink_clustering -main program to detect multilink communities in multiplex network

2) The auxiliary functions
Similarity
Sim_Multilink
ScoreLinkModularity

3) Files from the data repository http://deim.urv.cat/~manlio.dedomenico/data.php  on the Florentine Families dataset
with the addition of  a .m file (readme_florentine) to read the dataset and put it in the 
format readable by Multilink_clustering

To run the algorithm on this dataset first run readme_florentine
and then directly run the Multilink_clustering function 

The Multilink_clustering function takes as input:

1. a cell A of M sparse undirected adjacency matrices (ordered layers of the multiplex network)
   ex. A{1} is a N times N adjacency matrix of layer 1
2. the z parameter of the Multilink Community Detection algorithm
3. the epsilon parameter of the Multilink Community Detection algorithm
4. an optional parameter for printing figures on the scorefunction
profile (link modularity, the dendrogram and the similarity matrix)

It produces as an output:

1. edge list in the form of array links having each element equal to the
   pair of nodes connected.
 The n-th multilink is indicated by the couple of values
 links(n,1) indicating the first node of the multilink 
 links(n,2) indicating the second node of the multilink

2. mutlilinks_community is an array attributing to each multilink a community
 link_community(n) gives the community of the n-th multilinks
3. Z dendrogram
4. K_partition optimal cut of the dendrogram



 This code can be redistributed and/or modified
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or (at
 your option) any later version.
  
 This program is distributed ny the authors in the hope that it will be 
 useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  
 If you use this code please cite 

 [1]   R.J. Mondragon, J.Iacovacci,  and G. Bianconi, 
"Multilinks Communities of  Multiplex Networks"
  (2017).

 (c) 
     Ginestra Bianconi (g.bianconi@qmul.ac.uk) 
     Raul J. Mondragon (r.j.mondragon@qmul.ac.uk)
     Jacopo Iacovacci   (j.iacovacci@qmul.ac.uk)
