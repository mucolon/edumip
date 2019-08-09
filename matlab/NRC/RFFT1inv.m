function [u]=RFFT1inv(uhat,N)
% function [u]=RFFT1inv(uhat,N)
% INPUT: uhat is a complex array of length N/2.  It contains half of the fft of u,
% for the wavenumbers 0 to N/2.  
% OUTPUT: u is a real array of length N=2^s.
% This routine was written by inverting the steps of RFFT1 and doing them in reverse.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 5.5.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap05">Chapter 5</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also RFFT1.  Verify with: RFFT1Test.

uehat(1)=real(uhat(1))+imag(uhat(1))+i*real(uhat(N/4+1))*2;
uohat(1)=real(uhat(1))-imag(uhat(1))-i*imag(uhat(N/4+1))*2;
M=N/2+2;
for n=2:N/4
  uehat(n)=(uhat(n,1)+conj(uhat(M-n,1)));
  uohat(n)=(uhat(n,1)-conj(uhat(M-n,1)))/exp(-2*pi*i*(n-1)/N);
end
[ue,uo]=RFFT2inv(uehat,uohat,N/2);
u(1:2:N-1,1)=ue'; u(2:2:N,1)=uo';
end % function RFFT1inv
