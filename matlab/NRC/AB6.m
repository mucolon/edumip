function [x,t,s]=AB6(R,x,t,s,p,v,SimPlot)
% function [x,t,s]=AB6(R,x,t,s,p,v,SimPlot)
% Simulate x'=f(x), with f implemented in R, using the AB6 method.
% {x,t} contains the initial {x,t} on input and the final {x,t} on output.
% The simulation parameters are s.MaxTime, s.MaxSteps, s.h (timestep), and s.f,
% which contains the 5 most recent values of f on input (from a prior call to AB5/AB6),
% and the 6 most recent values of f on output (facilitating a subsequent call to AB6).
% The function parameters p, whatever they are, are simply passed along to R.
% If v<>0, SimPlot is called at each timestep to make interactive plots.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 10.4.2.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap10">Chapter 10</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also EE, AB2, AB3, AB4, AB5.  Verify with ABtest.

if v, xold=x; end
for n=1:min((s.MaxTime-t)/s.h,s.MaxSteps)
  s.f=[feval(R,x,p) s.f(:,1:5)];
  x=x+s.h*(4277*s.f(:,1)-7923*s.f(:,2)+9982*s.f(:,3)-7298*s.f(:,4)+2877*s.f(:,5)-475*s.f(:,6))/1440;
  t=t+s.h; if v, feval(SimPlot,xold,x,t-s.h,t,s.h,s.h,v); xold=x; end
end
end % function AB6
