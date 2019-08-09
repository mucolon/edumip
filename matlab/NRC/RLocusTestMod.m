% script <a href="matlab:RLocusTest">RLocusTest</a>
% Test <a href="matlab:help RLocus">RLocus</a> on several examples (NR Figures 18.2-18.4).
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 18.1.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap18">Chapter 18</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

close all
figure(1), K=logspace(-2,3,200);   axes=[-2.5 .5 -1.5 1.5]; RLocusMod([1 4 4],[1 0 1],1,1,K,axes)
figure(2), K=logspace(-1.8,2,600); axes=[-7 1 -4 4];        RLocusMod([1 2],[1 0 0],1,1,K,axes)
figure(3), K=logspace(-1.8,2,400); axes=[-3 1 -2 2];        RLocusMod([2],[1 2 0],1,1,K,axes)

c=2; K=logspace(-2,2,400); axes=[-2.2 .2 -1.2 1.2];
figure(4), RLocusMod([1 c],[c 0],1,1,K,axes)
figure(5), RLocusMod(1,[1 0],1,1,K,axes)

K=logspace(-3.5,3.5,400); axes=[-2.2 .2 -1.2 1.2];
figure(6), RLocusMod([1 2*c c^2],[c 0 0],1,1,K,axes)
figure(7), RLocusMod(1,[1 0 0],1,1,K,axes)

K=logspace(-3.5,4,400); axes=[-3 1 -2 2]; 
figure(8), RLocusMod([1 3*c 3*c^2 c^3],[c 0 0 0],1,1,K,axes)
figure(9), RLocusMod(1,[1 0 0 0],1,1,K,axes)

K=logspace(-2,2,700); axes=[-12 2 -5 5]; 
figure(10), RLocusMod([1 .3],[1 12 20 0 0],15,1,K,axes)
figure(11), RLocusMod([1 .2],[1 12 20 0 0],15,1,K,axes)

% end script RLocusTest
