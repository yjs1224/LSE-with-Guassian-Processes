function z = sample(x,y,noise)
z = sin(10*x) + cos(4*y) -cos(3*x*y);
if noise == true
    z = z + normrnd(0,exp(-1));
end
end