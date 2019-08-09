% ---------------------- CHAPTER 10: ORDINARY DIFFERENTIAL EQUATIONS ----------------------
% Attendant to the text  <a href="matlab:web('http://numerical-renaissance.com/')">Numerical Renaissance: simulation, optimization, & control</a>
% Files in Chapter 10 of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>:
%   ResponseSS           - function ResponseSS(A,B,C,D,type,g)
%   ResponseSSTest       - script <a href="matlab:ResponseSSTest">ResponseSSTest</a>
%   StabContours         - script <a href="matlab:StabContours">StabContours</a>
%   RK2                  - function [x,t]=RK2(R,x,t,s,p,v,SimPlot)
%   RK4                  - function [x,t]=RK4(R,x,t,s,p,v,SimPlot)
%   RK45                 - function [x,t]=RK45(R,x,t,s,p,v,SimPlot)
%   RKW3_2R              - function [x,t]=RKW3_2R(R,x,t,s,p,v,SimPlot)
%   RK435_2R             - function [x,t]=RK435_2R(R,x,t,s,p,v,SimPlot)
%   RK435_3R             - function [x,t]=RK435_3R(R,x,t,s,p,v,SimPlot)
%   RK548_3R             - function [x,t]=RK548_3R(R,x,t,s,p,v,SimPlot)
%   RKtest               - script <a href="matlab:RKtest">RKtest</a>
%   RHS_Lorenz           - function f=RHS_Lorenz(x,p)
%   RHS_Rossler          - function f=RHS_Rossler(x,p)
%   PlotLorenzRossler    - function PlotLorenzRossler(xo,xn,to,tn,ho,hn,v)
%   Top                  - function Top(theta0,phidot0,deflection,p,s)
%   TopTest              - script <a href="matlab:TopTest">TopTest</a>
%   EE                   - function [x,t,s]=EE(R,x,t,s,p,v,SimPlot)
%   AB2                  - function [x,t,s]=AB2(R,x,t,s,p,v,SimPlot)
%   AB3                  - function [x,t,s]=AB3(R,x,t,s,p,v,SimPlot)
%   AB4                  - function [x,t,s]=AB4(R,x,t,s,p,v,SimPlot)
%   AB5                  - function [x,t,s]=AB5(R,x,t,s,p,v,SimPlot)
%   AB6                  - function [x,t,s]=AB6(R,x,t,s,p,v,SimPlot)
%   ABtest               - function <a href="matlab:ABtest">ABtest</a>
%   CNiter               - function [x,t,s]=CNiter(R,x,t,s,p,v,SimPlot)
%   AM3iter              - function [x,t,s]=AM3iter(R,x,t,s,p,v,SimPlot)
%   AM4iter              - function [x,t,s]=AM4iter(R,x,t,s,p,v,SimPlot)
%   AM5iter              - function [x,t,s]=AM5iter(R,x,t,s,p,v,SimPlot)
%   AM6iter              - function [x,t,s]=AM6iter(R,x,t,s,p,v,SimPlot)
%   AMtest               - function <a href="matlab:AMtest">AMtest</a>
%   IEiter               - function [x,t,s]=IEiter(R,x,t,s,p,v,SimPlot)
%   BDF2iter             - function [x,t,s]=BDF2iter(R,x,t,s,p,v,SimPlot)
%   BDF3iter             - function [x,t,s]=BDF3iter(R,x,t,s,p,v,SimPlot)
%   BDF4iter             - function [x,t,s]=BDF4iter(R,x,t,s,p,v,SimPlot)
%   BDF5iter             - function [x,t,s]=BDF5iter(R,x,t,s,p,v,SimPlot)
%   BDF6iter             - function [x,t,s]=BDF6iter(R,x,t,s,p,v,SimPlot)
%   BDFtest              - function <a href="matlab:BDFtest">BDFtest</a>
%   SolarSystemSimulator - function <a href="matlab:SolarSystemSimulator">SolarSystemSimulator</a>
%   FS_Bisection_Test    - script <a href="matlab:FS_Bisection_Test">FS_Bisection_Test</a>
%   FS_NR_CSD_Test       - script <a href="matlab:FS_NR_CSD_Test">FS_NR_CSD_Test</a>
%   FSmarch              - function y=FSmarch(x,v,m)
%   FS_Relaxation_Test   - script <a href="matlab:FS_NR_CSD_Test">FS_Relaxation_Test</a>
% <a href="matlab:help NRchap09"><-previous</a> ---------- please read the <a href="matlab:help NRcopyleft">copyleft</a>, and please <a href="matlab:help NRsupport">support</a> us! ----------- <a href="matlab:help NRchap11">next-></a>
