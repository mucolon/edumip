function [f]=BicubicSpline(x,y,xd,yd,fd,fx,fy,fxy,Ainv)
% function [f]=BicubicSpline(x,y,xd,yd,fd,fx,fy,fxy,Ainv)
% Given the grid of datapoints {xd,yd,fd}, as well as the derivatives {fx,fy,fxy} on this
% same grid and Ainv (as computed by BicubicSplineSetup), determine the bicubic spline
% interpolant f on the grid {x,y}.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.3.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also BilinearSpline.  Verify with BicubicSplineTest.
      
ndx=length(xd); ndy=length(yd); nx=length(x); ny=length(y); i=1; 
for ii=1:nx; j=1;
  for i=i:ndx-1,   if xd(i+1)>x(ii), break, end, end % Find i s.t. xd(i)<=x(ii)<=xd(i+1)
  for jj=1:ny
    for j=j:ndy-1, if yd(j+1)>y(jj), break, end, end % Find j s.t. yd(j)<=y(jj)<=yd(j+1)
    x1=(x(ii)-xd(i))/(xd(i+1)-xd(i)); y1=(y(jj)-yd(j))/(yd(j+1)-yd(j));
    b=[fd(i,j);  fd(i+1,j);  fd(i,j+1);  fd(i+1,j+1); ...
       fx(i,j);  fx(i+1,j);  fx(i,j+1);  fx(i+1,j+1); ...
       fy(i,j);  fy(i+1,j);  fy(i,j+1);  fy(i+1,j+1); ...
       fxy(i,j); fxy(i+1,j); fxy(i,j+1); fxy(i+1,j+1)];
    a=Ainv*b;
    f(ii,jj)=0; for I=0:3, for J=0:3, f(ii,jj)=f(ii,jj)+a(1+I+4*J)*x1^I*y1^J; end, end
  end
end
end % function BicubicSpline
