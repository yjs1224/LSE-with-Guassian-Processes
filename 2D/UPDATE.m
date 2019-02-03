function [Ker,mu] = UPDATE(I_loc,I_sample)
n = length(I_loc);
Kn = zeros(n,n);
for m = 1:n
    for m1 = 1:n
        Kn(m,m1) = my_kernel(I_loc(:,m),I_loc(:,m1));
    end
end
mu = zeros(n,1);
Ker = Kn;