% script <a href="matlab:FindRootBracketTest">FindRootBracketTest</a>
% Test <a href="matlab:help FindRootBracket">FindRootBracket</a> on the function in <a href="matlab:help Example_3_2_Compute_f">Example_3_2_Compute_f</a>.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 3.1.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap03">Chapter 3</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also BisectionTest, FalsePositionTest. 

clear; p=[1 1 -20 50];

disp('Now testing FindRootBracket on the function in Example 3.2.')
[x1,x2]=FindRootBracket(0,2,@Example_3_2_Compute_f,p), disp(' ')  

% end script FindRootBracketTest
