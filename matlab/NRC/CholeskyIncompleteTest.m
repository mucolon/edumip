% script <a href="matlab:CholeskyIncompleteTest">CholeskyIncompleteTest</a>
% Test <a href="matlab:help CholeskyIncomplete">CholeskyIncomplete</a> (and compare with <a href="matlab:help CholeskyIncomplete">Cholesky</a>) on a positive-definite sparse
% matrix given by a finite-difference discretization of the 2D Helmholtz eqn. [see (1.5)]
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 4.4.8.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap04">Chapter 4</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

disp('Now testing Cholesky & CholeskyIncomplete on a sparse A>0.')
n=5; m=5; c=.01; A=zeros(m*n,m*n); C=-c*diag(ones(n,1),0);
B=(1+4*c)*diag(ones(n,1),0)-c*diag(ones(n-1,1),-1)-c*diag(ones(n-1,1),1);
for i=0:m-1, A(i*n+1:(i+1)*n,i*n+1:(i+1)*n)=B; end
for i=0:m-2, j=i+1; k=i+2;  A(i*n+1:j*n,j*n+1:k*n)=C;  A(j*n+1:k*n,i*n+1:j*n)=C;  end
A(1:n,(m-1)*n+1:m*n)=C;  A((m-1)*n+1:m*n,1:n)=C; n=n*m;
format +; A
Gfull = Cholesky(A,n)           % Gfull loses the sparsity structure of A.
Ginc  = CholeskyIncomplete(A,n) % Ginc retains the sparsity structure of A.
Gdiag = diag(sqrt(diag(A)))     % Gdiag is just the square root of the diagonal of A.
format short;
normA = norm(A),                   disp('This is a measure of A.')
error_Gfull= norm(Gfull*Gfull'-A), disp('This is near zero, indicating Cholesky.m works.')
error_Gdiag= norm(Gdiag*Gdiag'-A), disp('Gdiag is a zero-th order approximation of Gfull.')
error_Ginc = norm(Ginc*Ginc'-A),   disp('Ginc is a much better approximation of Gfull.')
disp(' ')
% end script CholeskyIncompleteTest