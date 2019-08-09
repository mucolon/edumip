function BistritzSimplified(p)
% function BistritzSimplified(p)    % STILL INCOMPLETE
% Compute the simplified Bistritz table to determine if p(s) is Schur. p(s) may be symbolic.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 18.1.1.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap18">Chapter 18</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also RouthSimplified, PolyStationarity.  Verify with BistritzSimplifiedTest.

n=length(p)-1; s=strcmp(class(p),'sym'); R=0; f=1;
uip2=p+p(end:-1:1);                 n,   uip20=vpa(uip2(end))
uip1=PolyDiv(p-p(end:-1:1),[1 -1]); n-1, uip10=vpa(uip1(end))
for i=n-2:-1:0
  a=uip20/uip10;        if a==0, disp('Not Schur.'), f=0; break, end
  i, ui=PolyAdd(a*PolyConv([1 1],uip1),-uip2); ui=ui(2:end-1); ui0=vpa(ui(end))
  uip2=uip1; uip20=uip10; uip1=ui; uip10=ui0;  if ~s, if a<0; R=R+1; end, end
end
if f, if s, disp('Schur iff all entries in first column are the same sign.'), else
      if R==0, disp('Schur'), else, disp(['Not Schur']), end, end, end
end % function BistritzSimplified
