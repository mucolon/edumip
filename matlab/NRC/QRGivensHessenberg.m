function [A,Q] = QRGivensHessenberg(A)
% function [A,Q] = QRGivensHessenberg(A)
% Compute a QR decomposition A=QR by applying a sequence of min(n,m-1) Givens rotations
% to an mxn upper Hessenberg matrix A to reduce it to upper triangular form.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 2.3.4.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap04">Chapter 2</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Depends on <a href="matlab:help RotateCompute">RotateCompute</a>, <a href="matlab:help Rotate">Rotate</a>.

[m,n]=size(A);  Q=eye(m,m);      % Note: R is returned in the modified A.
for i=1:min(n,m-1)
  [c,s]=RotateCompute(A(i,i),A(i+1,i)); [A]=Rotate(A,c,s,i,i+1,i,n,'L'); 
  [Q]=Rotate(Q,c,s,i,i+1,1,m,'R');
end
end % function QRGivensHessenberg
