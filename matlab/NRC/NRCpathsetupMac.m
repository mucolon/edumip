% script <a href="matlab:NRCpathsetup">NRCpathsetup</a>
% Initialize the path environment for using the Numerical Renaissance Codebase.
% Tip: set up a symbolic link in a convenient place to make it easy to call this script
% when firing up matlab or octave.  This can be done, e.g., in Mac OS X as follows:
%   ln -s /usr/local/lib/NRC/NRchapAA/NRCpathsetup.m ~/Documents/MATLAB/startup.m
% Be sure to modify "base" appropriately below if the NRC library is not in /usr/local/lib
% See <a href="matlab:NRweb">Numerical Renaissance</a>, Appendix A, for further discussion.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAA">Appendix A</a>; see webpage for <a href="matlab:help NRcopyleft">copyleft info</a>.                                                                   

base='/usr/local/lib/NRC/'; format compact, clc, close all, cd ~
addpath(strcat(base,'NRchap01'),strcat(base,'NRchap02'),strcat(base,'NRchap03'), ...
        strcat(base,'NRchap04'),strcat(base,'NRchap05'),strcat(base,'NRchap06'), ...
        strcat(base,'NRchap07'),strcat(base,'NRchap08'),strcat(base,'NRchap09'), ...
        strcat(base,'NRchap10'),strcat(base,'NRchap11'),strcat(base,'NRchap12'), ...
        strcat(base,'NRchap13'),strcat(base,'NRchap14'),strcat(base,'NRchap15'), ...
        strcat(base,'NRchap16'),strcat(base,'NRchap17'),strcat(base,'NRchap18'), ...
        strcat(base,'NRchap19'),strcat(base,'NRchap20'),strcat(base,'NRchap21'), ...
        strcat(base,'NRchap22'),strcat(base,'NRchapAA'),strcat(base,'NRchapAB'), ...
        strcat(base,'NRextra' ),strcat(base,'NRextra/exportfig'),base)
disp(['  Path set for using Numerical Renaissance Codebase; ' ...
         'type <a href="matlab:help NRC">help NRC</a> to get started.' char(10)])
% end script NRCpathsetup
