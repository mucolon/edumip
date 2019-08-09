function IntRombergTest
% function <a href="matlab:IntRombergTest">IntRombergTest</a>
% Test <a href="matlab:help IntRomberg">IntRomberg</a> on a representative scalar function.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 9.3.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap09">Chapter 9</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also IntTrapezoidalTest, IntAdaptiveTest.

disp('Testing the Romberg integration method.')
figure(1); clf; hold off; L=.1; R=2; int=IntRomberg(@Compute_f_Test,L,R,8)
disp('Note that we used half of the function evaluations as used in the trapezoidal case.')
disp(' ')
end % function IntRombergTest
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f=Compute_f_Test(x)
f=sin(1./x); plot(x,f,'x'); hold on
end % function Compute_f_Test
