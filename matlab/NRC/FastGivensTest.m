% script <a href="matlab:FastGivensTest">FastGivensTest</a>
% Tests <a href="matlab:help FastGivensCompute">FastGivensCompute</a> & <a href="matlab:help FastGivens">FastGivens</a> on a random matrix.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.11.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

RotateTest
disp('Now testing FastGivensCompute & FastGivens on a random matrix.'),  d=ones(4,1);
[a,b,gamma,donothing,d([2 3])]=FastGivensCompute(A(2,1),A(3,1),d(2),d(3));
[X_from_FastGivens]=FastGivens(A,a,b,gamma,donothing,2,3,1,4,'B'); scaling=diag(1./sqrt(d));
X_from_FastGivens_Scaled=scaling*X_from_FastGivens*scaling, disp(' ')

% end script FastGivensTest
