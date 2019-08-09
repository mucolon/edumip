function R=Hankel(top,right)
% function R=Hankel(top,right)
% Build an nxn Hankel matrix with the specified top row and right column.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Chapter 1 Exercises.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Verify with <a href="matlab:help HankelTest">HankelTest</a>.

n=length(top); for row=1:n; R(row,:)=[top(row:n) right(2:row)]; end
end % function Hankel
