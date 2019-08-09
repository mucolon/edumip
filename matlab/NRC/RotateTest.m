% script <a href="matlab:RotateTest">RotateTest</a>
% Test <a href="matlab:help RotateCompute">RotateCompute</a> & <a href="matlab:help Rotate">Rotate</a> on a random matrix.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.10.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

disp('Now testing RotateCompute & Rotate on a random matrix.')
A=randn(4)+sqrt(-1)*randn(4); A=A*A'
[c,s]=RotateCompute(A(2,1),A(3,1)); [X_from_Rotate]=Rotate(A,c,s,2,3,1,4,'B'), disp(' ')

% end script RotateTest
