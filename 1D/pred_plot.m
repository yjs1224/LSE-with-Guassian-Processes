function pred_plot(I_loc,I_sample,Omega)
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
figure;
hold on;
U = mu_p + beta*sigma_p;
D = mu_p - beta*sigma_p;
plot(Omega,mu_p-beta*sigma_p);
sum((D>0.1)&((Omega.*sin(10*Omega))>0.1))/sum((Omega.*sin(10*Omega)>0.1))
plot(Omega,mu_p+beta*sigma_p);
plot(Omega,Omega.*sin(10*Omega));
% legend('l(x)','u(x)','f(x)');
% title('Eqn 6')
hold off
end