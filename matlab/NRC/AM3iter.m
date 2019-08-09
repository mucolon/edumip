function [x,t,s]=AM3iter(R,x,t,s,p,v,SimPlot)
% function [x,t,s]=AM3iter(R,x,t,s,p,v,SimPlot)
% Simulate x'=f(x), with f implemented in R, using the iterative AM3 method with an AB3
% predictor.  {x,t} contains the initial {x,t} on input and the final {x,t} on output.
% The simulation parameters are s.MaxTime, s.MaxSteps, s.MaxIters, s.h (timestep), and s.f,
% which contains the 2-3 most recent values of f on input (from a call to AM2iter/AM3iter),
% and the 3 most recent values of f on output (facilitating a call to AM3iter/AM4iter).
% The function parameters p, whatever they are, are simply passed along to R.
% If v<>0, SimPlot is called at each timestep to make interactive plots.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 10.4.2.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap10">Chapter 10</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also CNiter, AM4iter, AM5iter, AM6iter.  Verify with AMtest.

xold=x; for n=1:min((s.MaxTime-t)/s.h,s.MaxSteps)
  if n==1 & size(s.f,2)==2                                         % n=1: Predict with AB2
    x=xold+s.h*(3*s.f(:,1)-s.f(:,2))/2;                                   
  else                                                             % n>1: Predict with AB3
    x=xold+s.h*(23*s.f(:,1)-16*s.f(:,2)+5*s.f(:,3))/12;              
  end
  s.f(:,2:3)=s.f(:,1:2);                           
  for m=1:s.MaxIters, s.f(:,1)=feval(R,x,p);                % Iteratively correct with AM3
    x=xold+s.h*(5*s.f(:,1)+8*s.f(:,2)-s.f(:,3))/12;         
  end, s.f(:,1)=feval(R,x,p);
  t=t+s.h; if v, feval(SimPlot,xold,x,t-s.h,t,s.h,s.h,v); end, xold=x; 
end
end % function AM3iter
