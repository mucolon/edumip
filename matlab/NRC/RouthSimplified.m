function RouthSimplified(p)
% function RouthSimplified(p)
% Compute the simplified Routh table to determine if p(s) is Hurwitz. p(s) may be symbolic.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 18.1.1.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap18">Chapter 18</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Routh, Bistritz, BistritzSimplified.  Verify with RouthSimplifiedTest.

n=length(p)-1; s=strcmp(class(p),'sym'); R=0; f=1; disp(p(1:2:end));
for i=n:-1:1
  disp(p(2:2:end)), if p(2)==0, disp('Not Hurwitz.'), f=0; break, end
  a=p(1)/p(2); p(3:2:i)=p(3:2:i)-a*p(4:2:i+1); p=p(2:i+1); if ~s, if a<0; R=R+1; end, end
end
if f, if s, disp('Hurwitz iff all entries in first column are the same sign.'), else
if R==0, disp('Hurwitz'), else, disp(['Not Hurwitz: ',num2str(R),' RHP poles']),end,end,end
end % function RouthSimplified
