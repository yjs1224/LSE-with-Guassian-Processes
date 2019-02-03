function y = sample(x,noise)
y = x*sin(10*x);
if noise == true
    y = y + normrnd(0,0.05);
end