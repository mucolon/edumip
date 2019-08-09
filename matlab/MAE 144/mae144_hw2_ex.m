clear, close all; clc

for j=1:2
  switch j
    case 1   % Improper D(s)
       b=[1 0 -4], a=[1 0 -10 0 9], f=PolyConv([1 1],[1 1],[1 3],[1 3])
    case 2   % Proper D(s)
       b=[1 0 -4], a=[1 0 -10 0 9],
       f=PolyConv([1 1],[1 1],[1 3],[1 3],[1 30],[1 30],[1 30],[1 30])
  end
  [g,q,n,a,b] = GCF(a,b);     % Apply Euclid's alorithm to find the GCF g
  [x,y] = Bezout(a,b,g,q,n);  % Apply the extended Euclidean algorithm to solve a*x+b*y=g
  % Now compute solution {X,Y}, of greatest relative degree, of Diophantine equation a*X+b*Y=f.
  [X,Y] = Diophantine(a,b,g,PolyDiv(f,g),x,y), poles=roots(X)', zeros=roots(Y)'
  G=tf(b,a); figure(1), bode(G), figure(2), rlocus(G)
  pLength=length(poles); zLength=length(zeros);
  p=cell(1,pLength); z=cell(1,zLength);
  for i=1:pLength, p{i}=[1 -poles(i)]; end
  kp=pLength; kz=zLength; pConv=1; zConv=1;
  while kp>=1, pConv=PolyConv(pConv,p{kp}); kp=kp-1; end
  for i=1:zLength, z{i}=[1 -zeros(i)]; end
  while kz>=1, zConv=PolyConv(zConv,z{kz}); kz=kz-1; end
  % T = (b*y)/(b*y+a*x), y:zeros, x:poles
  T_pConv=real(pConv); T_zConv=real(zConv);
  T_num=PolyConv(b,T_zConv);
  T_den=PolyAdd(PolyConv(b,T_zConv),PolyConv(a,T_pConv));
  if j==1, T=tf(T_num,T_den); figure(3), bode(T), figure(4), rlocus(T), end
  if j==2, K=Y(1); T=tf(K*T_num,T_den); figure(3), bode(T), figure(4), rlocus(T), end
  f_test=PolyAdd(PolyConv(a,X),PolyConv(b,Y)); f_test=f_test(find(abs(f_test)>1e-8,1):end)
  cl_poles=roots(f_test)', residual=norm(PolyAdd(f,-f_test))
  if j<2, disp(' '), pause, end
end
