clear; clc; close all;
N_length = 1000;
Ex = zeros(1,N_length);
nlogn = zeros(1,N_length);
n2logn = zeros(1,N_length);

iter = 1;
for n = [1:N_length]
    ans = 0;
    for i = [1:n]
        ans = ans + n/(n+1-i);
    end
    Ex(iter) = ans;
    nlogn(iter) = n*log(n);
    n2logn(iter) = 1.2*n*log(n);
    iter = iter + 1;
end

figure(1);
plot([1:N_length], Ex, 'b');
hold on;
plot([1:N_length], nlogn, 'r');
hold on;
plot([1:N_length], n2logn, 'm');
hold on;

title('E[X^{(n)}] vs N for \theta');
xlabel('N');
ylabel('plots');
legend('E[X^{(n)}]', 'NlogN', '1.2NlogN');
legend('Location', 'northwest')
    