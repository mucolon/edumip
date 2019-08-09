% script <a href="matlab:LinearSplineTest">LinearSplineTest</a>
% Test <a href="matlab:help LinearSpline">LinearSpline</a> on data from a smooth function.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.3.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

close all, clear, L=4*pi; xmin=0; xmax=L; ep=.0001; nd=10; n=100;
xd=[xmin:L/(nd-1):xmax]; fd=sin(xd+ep)./(xd+ep); x=[xmin:L/(n-1):xmax]; f=sin(x+ep)./(x+ep);
LS=LinearSpline(x,xd,fd); plot(xd,fd,'k+',x,f,'k--',x,LS,'k-'); axis([0 L -.25 1.05])

% end script LinearSplineTest
