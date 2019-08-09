function [x,t,s]=CNiter(R,x,t,s,p,v,SimPlot)
% function [x,t,s]=CNiter(R,x,t,s,p,v,SimPlot)
% Simulate x'=f(x), with f implemented in R, using the iterative CN method with an AB2
% predictor.  {x,t} contains the initial {x,t} on input and the final {x,t} on output.
% The simulation parameters are s.MaxTime, s.MaxSteps, s.MaxIters, s.h (timestep), and s.f,
% which contains the 1-2 most recent value(s) of f on input (from, e.g., a call to CNiter),
% and the 2 most recent values of f on output (facilitating a call to CNiter/AM3iter).
% The function parameters p, whatever they are, are simply passed along to R.
% If v<>0, SimPlot is called at each timestep to make interactive plots.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 10.4.2.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap10">Chapter 10</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also AM3iter, AM4iter, AM5iter, AM6iter.  Verify with AMtest.

xold=x; for n=1:min((s.MaxTime-t)/s.h,s.MaxSteps)
  if n==1 & size(s.f,2)==1                                         % n=1: Predict with EE
    x=xold+s.h*s.f(:,1);                                   
  else                                                             % n>1: Predict with AB2
    x=xold+s.h*(3*s.f(:,1)-s.f(:,2))/2;                                   
  end
  s.f(:,2)=s.f(:,1);                           
  for m=1:s.MaxIters, s.f(:,1)=feval(R,x,p);                % Iteratively correct with CN
    x=xold+s.h*(s.f(:,1)+s.f(:,2))/2;         
  end, s.f(:,1)=feval(R,x,p);
  t=t+s.h; if v, feval(SimPlot,xold,x,t-s.h,t,s.h,s.h,v); end, xold=x; 
end
end % function CNiter
