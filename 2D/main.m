clear;
close all;
x = 0:1/29:1;
y = 0:2/59:2;
[X,Y] = meshgrid(x,y);
Z =  sin(10*X)+cos(4*Y)-cos(3*X.*Y);
% contour(X,Y,Z,'ShowText','on');
Omega_x = X;
Omega_y = Y;
I_loc = [7/29,21/29,7/29,21/29;28/59,28/59,88/59,88/59];
% I_loc =[];
% for n = 1:4
%     I_x = double(int16(rand(1,1)*29))/29;
%     I_y = double(int16(rand(1,1)*59))/29.5;
%     I_loc = [I_loc,[I_x;I_y]];
% end
I_sample = zeros(length(I_loc),1);
for n = 1:length(I_loc)
    I_sample(n) = sample(I_loc(1,n),I_loc(2,n),true);
end
h = 1;
num_iter = 30;
%%
for n =1:num_iter
    [I_loc,I_sample] = select(I_loc,I_sample,Omega_x,Omega_y,Z,h);
%     pred_plot(I_loc,I_sample,Omega_x,Omega_y,Z);
    if  rem(n,30) == 0
        pred_plot(I_loc,I_sample,Omega_x,Omega_y,Z);
    end
end
%pred_plot(I_loc,I_sample,Omega_x,Omega_y,Z);