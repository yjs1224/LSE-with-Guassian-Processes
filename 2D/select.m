function [I_loc_op,I_sample_op] = select(I_loc,I_sample,X,Y,Z,t)
[K,mu] = UPDATE(I_loc,I_sample);
[h,w] = size(X);
mu_p = zeros(h,w);
sigma_p = zeros(h,w);
U = zeros(h,w);
D = zeros(h,w);
beta = 1.96;
for n = 1:h
    for m = 1:w
        kn = zeros(length(mu),1);
        for a = 1:length(mu)
            kn(a) = my_kernel([X(n,m);Y(n,m)],I_loc(:,a));
        end
        mu_p(n,m) = kn.' *(K+exp(-2)*eye(length(mu)))^(-1)* I_sample;
        sigma_p(n,m) = sqrt(my_kernel([X(n,m),Y(n,m)],[X(n,m),Y(n,m)])-kn.' * (K+exp(-2)*eye(length(mu)))^(-1) *kn);
    end
end
U = mu_p + beta * sigma_p;
D = mu_p - beta * sigma_p;
%[M_h,I_h]=max(((U>t) & (D<t))*2.*sigma_p);
%[M_h,I_h]=max(((U>t) & (D<t)).*max(beta*sigma_p,min(U-t,t-D)));
%[M_h,I_h]=max(((U>t) & (D<t)).*min(U-t,t-D));
[M_h,I_h]=max(((U>t) & (D<t)).*sigma_p./abs(mu_p - t));
%[M_h,I_h]=max(((U>t) & (D<t)).*(beta*sigma_p-abs(mu_p - t)));
[~,I_w] = max(M_h);
% pred_plot(I_loc,I_sample,X,Y,Z);
% sum(sum((U>t) & (D<t)))
I_loc_op = [I_loc,[X(I_h(I_w),I_w);Y(I_h(I_w),I_w)]];
I_sample_op = [I_sample;sample(X(I_h(I_w),I_w),Y(I_h(I_w),I_w),true)];
end