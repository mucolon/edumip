function Wave1D_Analytic(L,Tmax,c,N,dt)
% function Wave1D_Analytic(L,Tmax,c,N,dt)
% This script simulates the 1D Wave equation with periodic boundary conditions.
% Iterative CN (with an AB2 predictor) is used with a second-order FD method in space.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 11.1.3.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap11">Chapter 11</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Wave1D_ItCN_Pade, Wave1D_Newmark_Pade.

dx=L/N; IterSteps=2; x=(-N/2:N/2-1)'*dx; t=0; q=exp(-x.^2/0.1); v=0;
PlotXY(x,q,t,-L/2,L/2,-0.2,1.2); vs=v; qs=v; a=dt*c^2/(2*dx^2); b=-dt*c^2/dx^2;
for n=1:Tmax/dt
  for m=1:IterSteps
    if m==1, qs=q+dt*(1.5*v-0.5*qs)/2; else, qs=q+dt*(vs+v)/2; end
    vs=qs+q; vs=v+a*vs([N 1:N-1],1)+b*vs([1:N],1)+a*vs([2:N 1],1);
  end
  t=t+dt; q=qs; qs=v; v=vs; PlotXY(x,q,t,-L/2,L/2,-0.2,1.2);
end
end % function Wave1D_Analytic
