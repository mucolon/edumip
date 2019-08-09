function [x,t,s]=AM6iter(R,x,t,s,p,v,SimPlot)
% function [x,t,s]=AM6iter(R,x,t,s,p,v,SimPlot)
% Simulate x'=f(x), with f implemented in R, using the iterative AM6 method with an AB6
% predictor.  {x,t} contains the initial {x,t} on input and the final {x,t} on output.
% The simulation parameters are s.MaxTime, s.MaxSteps, s.MaxIters, s.h (timestep), and s.f,
% which contains the 5 most recent values of f on input (from a call to AM5iter/AM6iter),
% and the 6 most recent values of f on output (facilitating a call to AM6iter).
% The function parameters p, whatever they are, are simply passed along to R.
% If v<>0, SimPlot is called at each timestep to make interactive plots.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 10.4.2.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap10">Chapter 10</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also CNiter, AM3iter, AM4iter, AM5iter.  Verify with AMtest.

xold=x; for n=1:min((s.MaxTime-t)/s.h,s.MaxSteps)
  if n==1 & size(s.f,2)==5                                         % n=1: Predict with AB5 
    x=xold+s.h*(1901*s.f(:,1)-2774*s.f(:,2)+2616*s.f(:,3)-1274*s.f(:,4)+251*s.f(:,5))/720;   
  else                                                             % n>1: Predict with AB6
    x=xold+s.h*(4277*s.f(:,1)-7923*s.f(:,2)+9982*s.f(:,3)-7298*s.f(:,4)+2877*s.f(:,5)-475*s.f(:,6))/1440;
  end
  s.f(:,2:6)=s.f(:,1:5);
  for m=1:s.MaxIters, s.f(:,1)=feval(R,x,p);                % Iteratively correct with AM6
    x=xold+s.h*(475*s.f(:,1)+1427*s.f(:,2)-798*s.f(:,3)+482*s.f(:,4)-173*s.f(:,5)+27*s.f(:,6))/1440;      
  end, s.f(:,1)=feval(R,x,p);
  t=t+s.h; if v, feval(SimPlot,xold,x,t-s.h,t,s.h,s.h,v); end, xold=x;
end
end % function AM6iter
