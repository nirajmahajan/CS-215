clear; clc;
N = [5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000];
probs = [0.05, 0.4, 0.15, 0.3, 0.1];
mads = zeros(1,length(N));

N_index = 1;
for N_iter = N
    datasetsize = 10000;
    avg_data = zeros(1, datasetsize);
    for i = 1:datasetsize
        % initialize the random variables
        random_variables = rand(1,N_iter);
        for rv_index = 1:N_iter
            if (random_variables(1,rv_index) < 0.05)
                random_variables(1,rv_index) = 1;
            elseif (random_variables(1,rv_index) < 0.45)
                random_variables(1,rv_index) = 2;
            elseif (random_variables(1,rv_index) < 0.60)
                random_variables(1,rv_index) = 3;
            elseif (random_variables(1,rv_index) < 0.90)
                random_variables(1,rv_index) = 4;
            else
                random_variables(1,rv_index) = 5;
            end
        end
        
        % add average to data
        avg_data(1,i) = (sum(random_variables)/N_iter);
    end
    
    mu = sum(sum(avg_data))/datasetsize;
    sigma = std(avg_data);
    
    figure(1);
    hist(avg_data, 50);
    title(sprintf('Histogram of average of random variables, N=%d', N_iter));
    fignamehist = sprintf('%d_hist.fig', N_iter);
    jpgnamehist = sprintf('%d_hist.jpg', N_iter);
    // saveas(figure(1), fignamehist, 'fig');
    // saveas(figure(1), jpgnamehist, 'jpg');
    figure(2);
    [f, x] = ecdf(avg_data);
    plot(x,f);
    hold on;
    p = normcdf(x, mu, sigma);
    plot(x, p, 'r');
    title(sprintf('Empirical and Guassian CDF, N=%d', N_iter));
    legend('Empirical CDF', 'Gaussian CDF');
    fignamecdf = sprintf('%d_cdf.fig', N_iter);
    jpgnamecdf = sprintf('%d_cdf.jpg', N_iter);
    // saveas(figure(2), fignamecdf, 'fig');
    // saveas(figure(2), jpgnamecdf, 'jpg');
    hold off;
%     pause(3);
    
    for i = 1:length(x)
        if (abs(f(i,1)-p(i,1))>mads(1,N_index))
            
            mads(1,N_index) = abs(f(i,1)-p(i,1));
        end
    end
    N_index = 1 + N_index;
end

figure(3);
semilogx(N, mads);
title('Maximum Absolute Difference (semilogx)');
xlabel('N values');
ylabel('MAD');
fignamesml = 'mad_semilogx.fig';
jpgnamesml = 'mad_semilogx.jpg';
// saveas(figure(3), fignamesml, 'fig');
// saveas(figure(3), jpgnamesml, 'jpg');

figure(4);
plot(N, mads);
title('Maximum Absolute Difference (normal)');
xlabel('N values');
ylabel('MAD');
figname = 'mad.fig';
jpgname = 'mad.jpg';
// saveas(figure(4), figname, 'fig');
// saveas(figure(4), jpgname, 'jpg');