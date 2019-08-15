clear;clc;
x = [-3:0.02:3];
y = 5*sin(2.2*x + pi/3);
z=y;
to_corrupt = randperm(length(y), round(0.3*length(y)));

for elem = to_corrupt
    z(1,elem) = y(1,elem) + 100 + 20*(rand);
end

% Now Filtering wrt median
y_median=y;
n=length(y);
for elem = 1:n
    if(elem <= 8 && n-elem <= 8)
        y_median(1,elem) = median(z);
    elseif(elem <= 8)
        y_median(1,elem) = median(z(:,1:elem + 8));
    elseif(n-elem <= 8)
        y_median(1,elem) = median(z(:,(elem - 8):end));
    else
        y_median(1,elem) = median(z(:,(elem - 8):(elem + 8)));
    end
end

% Now Filtering wrt mean
y_mean=y;
n=length(y);
for elem = 1:n
    if(elem <= 8 && n-elem <= 8)
        y_mean(1,elem) = mean(z);
    elseif(elem <= 8)
        y_mean(1,elem) = mean(z(:,1:elem + 8));
    elseif(n-elem <= 8)
        y_mean(1,elem) = mean(z(:,(elem - 8):end));
    else
        y_mean(1,elem) = mean(z(:,(elem - 8):(elem + 8)));
    end
end

% Now Filtering wrt mean
y_quart=y;
n=length(y);
for elem = 1:n
    if(elem <= 8 && n-elem <= 8)
        y_quart(1,elem) = quantile(z,0.25);
    elseif(elem <= 8)
        y_quart(1,elem) = quantile(z(:,1:elem + 8), 0.25);
    elseif(n-elem <= 8)
        y_quart(1,elem) = quantile(z(:,(elem - 8):end), 0.25);
    else
        y_quart(1,elem) = quantile(z(:,(elem - 8):(elem + 8)), 0.25);
    end
end

plot(x,y,'g');
hold on;
plot(x,z,'c');
hold on;
plot(x,y_mean,'r');
hold on;
plot(x,y_median,'b');
hold on;
plot(x,y_quart,'k');
legend('clean','corrupted','mean','median','quartile')

hold off;

fprintf('mean = %f\n', (sum((y_mean-y).^2))/(sum((y.^2))));
fprintf('median = %f\n', (sum((y_median-y).^2))/(sum((y.^2))));
fprintf('quartile = %f\n', (sum((y_quart-y).^2))/(sum((y.^2))));