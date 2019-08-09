function Burgers_KS_CNRKW3_PS_KF
% function <a href="matlab:Burgers_KS_CNRKW3_PS">Burgers_KS_CNRKW3_PS</a>
% Simulate the 1D Burgers or KS equation on 0<x<L with periodic BCs using CN/RKW3 in time
% (explicit on nonlinear terms, implicit on linear terms) & pseudospectral in space.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 11.2.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap11">Chapter 11</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Burgers_CNRKW3_FD and Burgers_CNRKW3_FD_RS with FD implementations.

%%%%%%%%%%%%%%%%%%%% Initialize the simulation paramters (user input) %%%%%%%%%%%%%%%%%%%%
L=36.33; Tmax=100; N=64; dt=0.05; PlotInt=10; alpha=1; % alpha=0 for Burgers, alpha=1 for KS
dx=L/N; x=(0:N-1)'*dx; u =0.15*randn(N,1); uhat =RFFT(u,N);
                       ub=0.15*randn(N,1); ubhat=RFFT(ub,N);
%%%%%%%%%%%% Precalculate the time-stepping coefficients used in the simulation %%%%%%%%%%
h_bar=dt*[8/15 2/15 1/3]; beta_bar=[1 25/8 9/4]; zeta_bar=[0 -17/8 -5/4];
kx=(2*pi/L)*[0:N/2-1]'; if alpha==0; Aop=-kx.^2; else Aop=kx.^2-kx.^4; end;
hb2=h_bar/2; hbbb=beta_bar.*h_bar; hbzb=zeta_bar.*h_bar; Imhb2=1-h_bar/2;

%%%%%%%%%%%% Compute the estimator feedback gains %%%%%%%%%%
% solve AP+PA^H-PC^HR^(-1)*C*P+Q=0
% compute L=-PC^H(HPH^H +R)^(-1)




for k=1:Tmax/dt
  for rk=1:3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ALL 3 RK SUBSTEPS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    uhat(fix(N/3)+1:end)=0;  % Dealias (see Section 5.7).
    r=RFFTinv(uhat,N); r=-r.*r; rhat=i*kx.*RFFT(r,N);                % Leading-order cost:
    if (rk==1)                                                       % 2 FFTs per RK step
      uhat=(uhat+hb2(rk)*Aop.*uhat+hbbb(rk)*rhat)./(1-hb2(rk)*Aop);
    else        % Implement (10.64); note that the "solve" is now simply scalar division!
      uhat=(uhat+hb2(rk)*Aop.*uhat+hbbb(rk)*rhat+hbzb(rk)*rhat_old)./(1-hb2(rk)*Aop);
    end
    if (rk<3) rhat_old=rhat; end  % Save rhat for the next timestep

    ubhat(fix(N/3)+1:end)=0;  % Dealias (see Section 5.7).
    rb=RFFTinv(ubhat,N); rb=-rb.*rb; rbhat=i*kx.*RFFT(rb,N);         % Leading-order cost:
    if (rk==1)                                                       % 2 FFTs per RK step
      ubhat=(ubhat+hb2(rk)*Aop.*ubhat+hbbb(rk)*rbhat)./(1-hb2(rk)*Aop);
    else        % Implement (10.64); note that the "solve" is now simply scalar division!
      ubhat=(ubhat+hb2(rk)*Aop.*ubhat+hbbb(rk)*rbhat+hbzb(rk)*rbhat_old)./(1-hb2(rk)*Aop);
    end
    if (rk<3) rbhat_old=rbhat; end  % Save rbhat for the next timestep
  end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF RK LOOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  rs(k,:)=RFFTinv(uhat,N)'; ts(k)=k*dt; % These variables are just used for plotting...
  rbs(k,:)=RFFTinv(ubhat,N)';
  if (mod(k,PlotInt)==0) 
    % pause(0.001); figure(1); clf; plot(x,rs(k,:),'b-',x,rbs(k,:),'r-'); axis([0 L -1.5, 1.5]);
    %               xlabel('x'); ylabel('u'); title(sprintf('Time = %5.2f',k*dt));
    % Comment out the lines below to make some additional interesting plots.
    % figure(2); semilogy(kx(1:fix(N/3)),abs(uhat(1:fix(N/3))).^2); axis([0 3 1e-8 1e-1])
    % figure(3); loglog(kx(1:fix(N/3)),abs(uhat(1:fix(N/3))).^2); axis([3e-2 4 1e-8 1e-1])
  end
end
figure(4); rs(:,N+1)=rs(:,1); xs=[0:N]*L/N;
contour(xs,ts,rs,[.25 .75 1.25],'r-'); hold on; contour(xs,ts,rs,[-.25 -.75 -1.25],'b-.')
end % function Burgers_KS_CNRKW3_PS_KF
