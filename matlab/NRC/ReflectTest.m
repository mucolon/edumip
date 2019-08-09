% script <a href="matlab:ReflectTest">ReflectTest</a>
% Tests <a href="matlab:help ReflectCompute">ReflectCompute</a> and <a href="matlab:help Reflect">Reflect</a> on a random matrix.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.9.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

disp('Now testing ReflectCompute & Reflect on a random matrix.')
A=randn(4)+sqrt(-1)*randn(4)
[sig,w]=ReflectCompute(A(:,1)); [X_from_Reflect]=Reflect(A,sig,w,1,4,1,4,'L'), disp(' ')

% end script ReflectTest
