% -------------------------- CHAPTER 1: NOTATION AND DEFINITIONS --------------------------
% Attendant to the text <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>
% Files in Chapter 1 of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a> (in order of appearance):
%   TriDiag           - function [A]=TriDiag(a,b,c)
%   TriDiagTest       - script <a href="matlab:TriDiagTest">TriDiagTest</a>
%   Reflect           - function [X] = Reflect(X,sig,w,i,k,p,q,which)
%   ReflectCompute    - function [sig,w] = ReflectCompute(x)
%   ReflectTest       - script <a href="matlab:ReflectTest">ReflectTest</a>
%   Rotate            - function [X] = Rotate(X,c,s,i,k,p,q,which)
%   RotateCompute     - function [c,s] = RotateCompute(f,g)
%   RotateTest        - script <a href="matlab:RotateTest">RotateTest</a>
%   FastGivens        - function [X]=FastGivens(X,a,b,gamma,donothing,i,k,p,q,which)
%   FastGivensCompute - function [a,b,gamma,donothing,dnew]=FastGivensCompute(f,g,di,dk)
%   FastGivensTest    - script <a href="matlab:FastGivensTest">FastGivensTest</a>
%   Hankel            - function R=Hankel(top,right)
%   HankelTest        - script <a href="matlab:HankelTest">HankelTest</a>
%           LEGEND: the links at left open the corresponding help pages, whereas
%                   the links at right run the corresponding test scripts.
% <a href="matlab:help NRC">top</a> --------------- please read the <a href="matlab:help NRcopyleft">copyleft</a>, and please <a href="matlab:help NRsupport">support</a> us! ------------- <a href="matlab:help NRchap02">next-></a>
