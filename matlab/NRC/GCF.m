function [g,q,n,a,b] = GCF(a,b)
% function [g,q,n,a,b] = GCF(a,b)
% Find the GCF g(s) of {a(s),b(s)} via Euclid's algorithm.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Uses Swap, PolyDiv.  See GCFTest.

if length(b)>length(a), [a,b]=Swap(a,b); end, n=0; rm=a; r=b; while norm(r,inf)>1e-12
  % Reduce (rm,r) to their GCF via Euclid's algorithm, saving the quotients q.
  r=r(find(r,1):end); n=n+1; [q{n},rem]=PolyDiv(rm,r); rm=r; r=rem; end, g=rm;
end % function GCF
