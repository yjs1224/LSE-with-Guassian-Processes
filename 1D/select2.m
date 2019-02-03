function [I_loc_op,I_sample_op]= select2(Omega,I_loc,I_sample,h)
n = length(I_loc);
[K,mu] = UPDATE(I_loc,I_sample);
mu_p = zeros(1,length(Omega));
sigma_p = zeros(1,length(Omega));
beta = 1.96;
for m = 1:length(Omega)
    kn = zeros(n,1);
    for m1 =1:n
        kn(m1) = my_kernel(Omega(m),I_loc(m1));
    end
    mu_p(m) = kn.' *(K+0.0025*eye(n))^(-1) * (I_sample-mu);
    sigma_p(m) = sqrt(my_kernel(Omega(m),Omega(m)) -  kn.' *(K+0.0025*eye(n))^(-1) *kn);
end
U = mu_p + beta*sigma_p;
D = mu_p - beta*sigma_p;
%pred_plot(I_loc,I_sample,Omega);
%[~,LOC] = max((U>h & D<h)*2.*sigma_p);
[~,LOC] = max((U>h & D<h).*(sigma_p./abs(mu_p-h)));
%[~,LOC] = max((U>h & D<h).*min(U-h,h-D));
%[~,LOC] = max((U>h & D<h).*(beta*sigma_p - abs(mu_p-h)));
% hold on;
% plot(Omega,U)
% plot(Omega,D)
% hold off;
I_loc_op = [I_loc,Omega(LOC)];
I_sample_op = [I_sample;sample(Omega(LOC),true)];


