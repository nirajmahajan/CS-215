clear; clc;
N = [5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000];
probs = [0.05, 0.4, 0.15, 0.3, 0.1];


for N_iter = [5]
    avg_data = zeros(1, 1000);
    for i = 1:1000
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
    
    mu = sum(sum(avg_data))/1000;
    sigma = std(avg_data);
    
    figure(1);
    histogram(avg_data, 50);
    figure(2);
    ecdf(avg_data);
%     [f, x] = ecdf(avg_data);
%     hold on;
    normcdf(x, mu, sigma);
end

            
        
        