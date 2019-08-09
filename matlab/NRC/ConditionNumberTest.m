% script <a href="matlab:ConditionNumberTest">ConditionNumberTest</a>
% Calculate the perturbation dx to the solution x due to a perturbation db to the RHS b
% in the problem A*x=b for a matrix A with a large condition number.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 2.5.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap02">Chapter 2</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

% Set up a random A matrix and b vector, where A has a bad condition number.
clear; N=20; b=randn(N,1); A=randn(N)^7; condition_number_of_A=cond(A)

for k=1:2
  switch k
    case 1, disp('Now illustrating a benign case with b, db in random directions')
      b=randn(N,1); db=1e-6*randn(N,1); 
    case 2, disp('Now illustrating a pathological case with db in a direction masked by d')
      [lam,S]=Eig(A,'r'); s1=S(:,1); sN=S(:,N); b=s1; db=1e-6*sN;
  end
  x=A\b; xpdx=A\(b+db);
  norm_db_over_norm_b = norm(db)/norm(b)
  norm_dx_over_norm_x = norm(xpdx-x)/norm(x), disp(' '); if k==1, pause, end
end
% end script ConditionNumberTest
