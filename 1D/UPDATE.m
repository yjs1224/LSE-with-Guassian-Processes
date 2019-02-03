function [Ker,mu] = UPDATE(I_loc,I_sample)
n = length(I_loc);
Kn = zeros(n,n);
for m = 1:n
    for m1 = 1:n
        Kn(m,m1) = my_kernel(I_loc(m),I_loc(m1));
    end
end
mu = zeros(n,1);
Ker = zeros(n,n);
% for m=1:n
%     mu(m) = Kn(:,m) * (Kn + 0.0001 *eye(n))^(-1) * I_sample;
%     for m1 = 1:n
%         Ker(m,m1) = Kn(m,m1) - Kn(:,m) * (Kn + 0.0001 *eye(n))^(-1) * Kn(m1,:);
%     end
% end
Ker = Kn;