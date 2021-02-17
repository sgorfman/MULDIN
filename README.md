# MULDIN
The algorithm for target transformation of lattice basis vectors

Presented here are the algorithm for the transformation of lattice basis vectors to the specific target. The algorithms are useful for crystallographic operations in direct and reciprocal spaces alike. 

The details of the algorithm are described in the original research paper of the Author. It can be openly accessed here:
https://scripts.iucr.org/cgi-bin/paper?ae5090

The algorithm is realized using MATLAB. The input parameter is an integer vector (e.g. [1,2,3] or [-3,4,5,9] or [-151,45,67,87,0], there are no restriction on the maximum / minimum values of the elements, the number of elements, N defines dimensionality of the poroblem). The output of the algorithm is the NxN matrix, such that its determinant is equal to 1 and the last column is equal to the input vector.

This alforithms is useful for various tasks in crystallography (see the original publication for more details).
