function z=OrthGrid(II,JJ,type,g,c0x,c1x,c0y,c1y)
% function z=OrthGrid(II,JJ,type,g,c0x,c1x,c0y,c1y)
% Generate a few convenient locally-orthogonal 2D grids.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.6.2.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also CMGridTest.  Depends on Stretch1DMesh.  Verify with OrthGridTest.

x=Stretch1DMesh([0:1/(II-1):1],'p',0,1,c0x,c1x);
y=Stretch1DMesh([0:1/(JJ-1):1],'p',0,1,c0y,c1y);
switch type % Set up the grid in the z plane
  case 'Cartesian'
    for I=1:II, for J=1:JJ, z(I,J)=g.x0+x(I)*g.x1+i*y(J)*g.y1; end, end
  case 'ConfocalParabola'
    for I=1:II, for J=1:JJ, z(I,J)=x(I)*g.x1+i*y(J)*g.y1; end, end, z=z.^2+g.x0;
  case 'EllipseHyperbola'
    for I=1:II/2, a=2*x(II/2+I)-1; for J=1:JJ, b=y(J)*g.y1;
      if a==1, zr=sqrt(1+b^2); zi=0; else
        zr=sqrt((b^2+(1-a^2))/(b^2/(1+b^2)+(1-a^2)/a^2)); zi=sqrt(b^2-zr^2*b^2/(1+b^2));
      end, z(II/2+I,J)=zr+i*zi; z(II/2+1-I,J)=-zr+i*zi;   
    end, end
end
end % function OrthGrid
