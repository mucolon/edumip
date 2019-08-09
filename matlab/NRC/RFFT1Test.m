% script <a href="matlab:RFFT1Test">RFFT1Test</a>
% Test <a href="matlab:help RFFT1">RFFT1</a> and <a href="matlab:help RFFT1inv">RFFT1inv</a> with random u.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 5.5.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap05">Chapter 5</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also RFFT2Test, RFFTtest.

disp('Now testing RFFT1 and and RFFT1inv on a random real vector')
N=16; u=randn(N,1); uhat=RFFT1(u,N); u1=RFFT1inv(uhat,N);
original_u=u.', transformed=uhat.', transformed_back=u1.'
mean_of_u              =sum(u)/N
zero_wavenumber_of_uhat=real(uhat(1))
mean_square_of_u       =norm(u)^2/N
sum_of_squares_of_uhat =norm(real(uhat(1)))^2+norm(imag(uhat(1)))^2+2*norm(uhat(2:end))^2
transform_error = norm(u-u1)
mean_value_error= (mean_of_u-zero_wavenumber_of_uhat)^2
parseval_error  = (mean_square_of_u-sum_of_squares_of_uhat)^2                                                      

% end script RFFT1Test
