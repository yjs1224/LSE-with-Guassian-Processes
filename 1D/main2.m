clear ;
close all;
Omega = 0:0.001:0.999;
I_loc = [0.2,0.5,0.8];
% I_loc = zeros(1,3);
% for n = 1:3
%     I_loc(n) = double(int16(rand(1,1)*1000))/1000
% end
I_sample = zeros(3,1);
for n = 1:3
    I_sample(n) =sample(I_loc(n),true);
end
num_iter =1;
h = 0.1;
for n = 1:num_iter
    [I_loc,I_sample] =  select2(Omega,I_loc,I_sample,h);
end
pred_plot(I_loc,I_sample,Omega);