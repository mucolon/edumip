% script <a href="matlab:RFCTtest">RFCTtest</a>
% Test <a href="matlab:help RFCT">RFCT</a> and <a href="matlab:help RFCTinv">RFCTinv</a> with random u.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 5.11.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap05">Chapter 5</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also RFFTtest, RFCTtest.

disp('Now testing RFCT and RFCTinv on a random real vector')
N=8; u=randn(N+1,1); uhatc=RFCT(u,N); u1=RFCTinv(uhatc,N);
original_u=u.', transformed=uhatc.', transformed_back=u1.'
mean_of_u               =((u(1)+u(N+1))/2+sum(u(2:N)))/N
zero_wavenumber_of_uhatc=real(uhatc(1))
mean_square_of_u        =(norm([u(1) u(N+1)])^2/2 + norm(u(2:N))^2)/N
sum_of_squares_of_uhatc =norm([uhatc(1) uhatc(N+1)])^2+norm(uhatc(2:N))^2/2
transform_error = norm(u-u1)
mean_value_error= (mean_of_u-zero_wavenumber_of_uhatc)^2
parseval_error  = (mean_square_of_u-sum_of_squares_of_uhatc)^2                                                      

% end script RFFTtest
