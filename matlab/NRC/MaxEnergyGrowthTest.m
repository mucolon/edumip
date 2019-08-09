% script <a href="matlab:MaxEnergyGrowthTest">MaxEnergyGrowthTest</a>
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 20.1.5.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap20">Chapter 20</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

clear; n=4; Q=rand(n); Q=Q*Q';

R=randn(n); S=randn(n); A=-R*R'+S-S', tau=1,
disp('Eigenvalues of A (note: stable system with eigenvalues in LHP)');
disp(Eig(A,'r')), [thetamax,x0]=MaxEnergyGrowth(A,Q,tau,'CT')
xtau=MatrixExponential(A,tau)*x0; E0=x0'*Q*x0, Etau=xtau'*Q*xtau, disp(' '), pause

F=randn(n); F=0.95*F/max(abs(Eig(F,'r'))), m=8,
disp('Eigenvalues of F (note: stable system with eigenvalues in unit circle)');
disp(Eig(F,'r')), [thetamax,x0]=MaxEnergyGrowth(F,Q,m,'DT')
xm=F^m*x0; E0=x0'*Q*x0, Em=xm'*Q*xm, disp(' ')

disp('Next <a href="matlab:help NRchap20">NRchap20</a> demo: <a href="matlab:TFnormTest">TFnormTest</a>'), disp(' ')
% end script MaxEnergyGrowthTest
