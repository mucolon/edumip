function BSTplot(D,r,x,y)
% function BSTplot(D,r,x,y)
% Plot a BST so that the user can understand its structure and watch it evolve.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.1.7.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also BSTinitialize, BSTinsert, BSTrotateLR, BSTrotateL, BSTrotateR, BSTbalance,
% BSTenumerate, BSTsuccessor.  Verify with BSTtest.

if nargin==2;
  x=0; y=0; figure(2); clf; axis([-4.09 4.09 -10.21 0.5]); axis off; hold on;
end
s=D(r,end-3); if s>0; xn=x-1/2^(y-1); plot([x xn],[-y -y-1]); BSTplot(D,s,xn,y+1), end
s=D(r,end-1); if s>0; xn=x+1/2^(y-1); plot([x xn],[-y -y-1]); BSTplot(D,s,xn,y+1), end
fill([-.1 .1 .1 -.1]+x,[.2 .2 -.2 -.2]-y,'y'), text(x-0.04,-y,sprintf('%2d',D(r,end)))
end % function BSTplot                                   
