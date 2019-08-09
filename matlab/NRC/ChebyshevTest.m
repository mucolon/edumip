% script <a href="matlab:ChebyshevTest">ChebyshevTest</a>
% Test <a href="matlab:help Chebyshev">Chebyshev</a> by plotting the Chebyshev function and its derivatives
% at a few different orders.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 5.13.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap05">Chapter 5</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

clear, for n=5:-1:1
  figure(n); clf
  for i=0:250
    x(i+1)=-1.25+i*.01;
    T(i+1)  =Chebyshev(n,x(i+1),0,1);
    Tp(i+1) =Chebyshev(n,x(i+1),1,1);
    Tpp(i+1)=Chebyshev(n,x(i+1),2,1);
  end
  plot(x,T,'k-',x,Tp,'r-',x,Tpp,'b-'); grid; axis tight
end
% end script ChebyshevTest
