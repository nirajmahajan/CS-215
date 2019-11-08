clear;
clc;
rng(1000);

N = 10^5;
r = 2;
sum_x = 0;
sum_y = 0;

first_term = zeros(2,2);

for i = 1:N
    angle = 2*pi*rand();
    x = r*cos(angle);
    y = r*sin(angle);
    sum_x = sum_x + x;
    sum_y = sum_y + y;
    
    X = [x;y]*[x y];
    first_term = first_term + X;
end

mean = [sum_x/N; sum_y/N];
covariance = first_term/N - mean*transpose(mean);

mean
covariance
N
