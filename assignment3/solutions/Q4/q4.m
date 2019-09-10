clear;clc;
close all;
T = ones(1,750);
V = ones(1,250);

for i = [1:750]
    T(i) = normrnd(0,4);
end
for i = [1:250]
    V(i) = normrnd(0,4);
end

sigma_list = [0.001, 0.1, 0.2, 0.9, 1, 2, 3, 5, 10, 20, 100];
sigma_plot = zeros(1,11);
D_plot = zeros(1,11);

iter = 1;
for curr_sigma = sigma_list
    res = 0;
    D_res = 0;
    for curr_x = V
        to_be_log = 0;
        pxi = exp(-(curr_x^2)/32)/(4*sqrt(2*pi));
        p_hat_xi = 0;
        for curr_xi = T
            expto = -(((curr_x - curr_xi)^2)/(2*(curr_sigma^2)));
            to_be_log = to_be_log + exp(expto);
            
            p_hat_xi = p_hat_xi + (exp(-((curr_x-curr_xi)^2)/(2*curr_sigma^2))/(750*curr_sigma*sqrt(2*pi)));
        end
        res = res + log(to_be_log);
        D_res = D_res + ((pxi-p_hat_xi)^2);
    end
    res = res - (250*log(750*curr_sigma*sqrt(2*pi)));
    sigma_plot(iter) = res;
    D_plot(iter) = D_res;
    iter = iter + 1;
end

figure(1);
plot(log(sigma_list), sigma_plot);
hold on;
title('Q4-b: LL vs log(sigma)')
xlabel('log(sigma)');
ylabel('LL');

x_max = sigma_list(1);
max_val = sigma_plot(1);
Dx_max = sigma_list(1);
Dmax_val = D_plot(1);
for i = [1:11]
    if(sigma_plot(i) > max_val)
        max_val = sigma_plot(i);
        x_max = sigma_list(i);
    end
    if(D_plot(i)<Dmax_val)
        Dmax_val = D_plot(i);
        Dx_max = sigma_list(i);
    end
end

fprintf('Part B:\n')
fprintf('The maximum value of LL is %f\n',max_val);
fprintf('Best sigma value is %f\n\nPart C:\n', x_max);
plot(log(x_max), max_val, 'r*');
hold on;

figure(2);
plot(log(sigma_list), D_plot);
title('Q4-c: D vs log(sigma)')
xlabel('log(sigma)');
ylabel('D');

hold on;
plot(log(Dx_max), Dmax_val, 'r*');

fprintf('The minimum value of D is %f\n',Dmax_val);
fprintf('Best sigma value is %f\n',Dx_max);