function pred_plot(I_loc,I_sample,X,Y,Z)
[K,mu] = UPDATE(I_loc,I_sample);
[h,w] = size(X);
beta = 1.96;
mu_p = zeros(h,w);
sigma_p = zeros(h,w);
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
%sum(sum((mu_p-beta*sigma_p)>1))
sum(sum(((mu_p-beta*sigma_p)>1)&(Z>1)))/sum(sum(Z>1))
figure;
subplot(2,2,1);
contour(X,Y,mu_p - beta*sigma_p,'ShowText','on');
subplot(2,2,2);
contour(X,Y,Z,'ShowText','on');
subplot(2,2,3);
contour(X,Y,mu_p + beta*sigma_p,'ShowText','on');
subplot(2,2,4);
contour(X,Y,mu_p - beta*sigma_p,'ShowText','on');
hold on;
scatter(I_loc(1,:),I_loc(2,:),'filled');
title('Straddle');
hold off;