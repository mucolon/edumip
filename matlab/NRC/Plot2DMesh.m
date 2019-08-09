function Plot2DMesh(z,fig,II,JJ)
% function Plot2DMesh(z,fig,II,JJ)
% Plot a structured II by JJ mesh given by real and imaginary parts of z(1:II,1:JJ).
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 8.1.3.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap08">Chapter 8</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Stretch1DMesh.  Verify with: Plot2DMeshTest.

figure(fig); hold on; 
for i=1:II, plot(real(z(i,:)),imag(z(i,:)),'b-'); end
for j=1:JJ, plot(real(z(:,j)),imag(z(:,j)),'r-'); end, hold off; axis equal; axis off
end % function Plot2DMesh