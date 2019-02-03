function ker = my_kernel(x1,x2)%,sigma,l)
sigma = exp(1);
l = exp(-1.5);
ker = sigma^2*exp(-sum((x1-x2).^2)/(2*l^2));
