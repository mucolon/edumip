function [B,A] = Gauss(A,B,n)
% function [B,A] = Gauss(A,B,n)
% Solve AX=B for X using Gaussian elimination without pivoting.  The matrix B is replaced
% by the solution X on exit, and (if requested) the matrix A is replaced by the m_ij and U.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 2.2.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap02">Chapter 2</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also GaussLU. Verify with GaussTest.

for j = 1:n-1,                                                  % FORWARD SWEEP
   % Looping through each column j<n, compute the m_ij=-a_ij/a_jj for j+1<=i<=n.
   % For efficiency, store these m_ij in the column of A below the pivot, where the a_ij
   % used to sit. This is done without disrupting the rest of the algorithm, as these a_ij
   % are set to zero by construction during this iteration and not referenced later.
   A(j+1:n,j)     = - A(j+1:n,j) / A(j,j);
   % Add the m_ij, for j+1<=i<=n, times the upper triangular part of the j'th row of the
   % augmented matrix to the rows j+1:n (below the pivot) in the augmented matrix.
   A(j+1:n,j+1:n) = A(j+1:n,j+1:n) + A(j+1:n,j) * A(j,j+1:n);   % (Outer product update)
   B(j+1:n,:)     = B(j+1:n,:)     + A(j+1:n,j) * B(j,:);
end
for i = n:-1:1,                                                 % BACK SUBSTITUTION
   B(i,:) = ( B(i,:) - A(i,i+1:n) * B(i+1:n,:) ) / A(i,i);      % (Inner product update)
end
end % function Gauss
