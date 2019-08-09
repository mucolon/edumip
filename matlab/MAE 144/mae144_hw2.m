clear, close all; clc

% Used to get the convoluted form of G(s)
syms s
num_b=(s+2)*(s-2)*(s+4)*(s-4);
den_a=(s+1)*(s-1)*(s+3)*(s-3)*(s+5)*(s-5);
G=num_b/den_a;
G_exp=expand(G);
% Listing coefficients for G(s) & convoluting f(s)
for j=1:2
  switch j
    case 1   % Improper D(s)
       b=[1 0 -20 0 64], a=[1 0 -35 0 259 0 -225], f=PolyConv([1 1],[1 1],[1 3],[1 3],[1 5],[1 5])
    case 2   % Proper D(s)
       b=[1 0 -20 0 64], a=[1 0 -35 0 259 0 -225],
       f=PolyConv([1 1],[1 1],[1 3],[1 3],[1 5],[1 5],[1 50],[1 50],[1 30],[1 30],[1 10],[1 10])
  end
  [g,q,n,a,b] = GCF(a,b);     % Apply Euclid's alorithm to find the GCF g
  [x,y] = Bezout(a,b,g,q,n);  % Apply the extended Euclidean algorithm to solve a*x+b*y=g
  % Now compute solution {X,Y}, of greatest relative degree, of Diophantine equation a*X+b*Y=f.
  [X,Y] = Diophantine(a,b,g,PolyDiv(f,g),x,y), poles=roots(X)', zeros=roots(Y)'

%   finding the number of poles & zeros returned from Diophantine's Eqn
  xpLength=length(poles); yzLength=length(zeros);
  xp=cell(1,xpLength); yz=cell(1,yzLength);
%   placing poles & zeros into 1x2 vectors in order to convolute
  for i=1:xpLength, xp{i}=[1 -poles(i)]; end
  for i=1:yzLength, yz{i}=[1 -zeros(i)]; end
%   convoluting poles & zeros seperating
  kxp=xpLength; kyz=yzLength; xpConv=1; yzConv=1;
  while kxp>=1, xpConv=PolyConv(xpConv,xp{kxp}); kxp=kxp-1; end
  while kyz>=1, yzConv=PolyConv(yzConv,yz{kyz}); kyz=kyz-1; end
%   L = (b*y)/(a*x), y:zeros, x:poles
%   defining the denominator & numerator of D(s)
  Dx_den=real(xpConv); 
  Dy_num=real(yzConv);
%   getting the denominator & numerator of L(s)
  L_num=PolyConv(b,Dy_num);
  L_den=PolyConv(a,Dx_den);
%   bode plot of open loop system
  L=tf(L_num,L_den); figure(1), bode(L)
%   figure(2), rlocus(L)
  
  f_test=PolyAdd(PolyConv(a,X),PolyConv(b,Y)); f_test=f_test(find(abs(f_test)>1e-8,1):end)
  cl_poles=roots(f_test)', residual=norm(PolyAdd(f,-f_test))
  if j<2, disp(' '), pause, end
end