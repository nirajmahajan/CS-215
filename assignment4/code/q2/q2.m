clear; clc; close all;
rng(0);
plot_number = 1;

TrueCovariance = [1.6250, -1.9486; -1.9486, 3.8750];
TrueMean = [1 2]';

[EigenVectors, EigenValues] = eig(TrueCovariance);

% By spectral theorem C = U S U'     where U = eigenvector matrix
% Also C = A A'
% decompose S into square roots (should be real) for A, S = S1 * S1' (easy since S diagonal)
% A = U S1

S1 = sqrt(EigenValues);
A = EigenVectors * S1;

N_array = [10, 100, 1000, 10000, 100000];

Mean_errors = zeros(100, 5);
Variance_errors = zeros(100, 5);
iterg = 1;
for N = N_array
    % For every N, compute 100 Myu hats, store them in a cell
    for i = [1:100]
        % Nx2 matrix having N random variables MVG
        temp_data = (repmat(TrueMean, 1, N) + A*randn(2,N))';
        % Mu_hat corresponding to temp_data
        loop_mu_hat = myMean(temp_data);
        % Error corresponding to Mu_hat
        Mean_errors(i, iterg) = norm(TrueMean - loop_mu_hat')/norm(TrueMean);
        % C_hat corresponding to data
        loop_c_hat = ((temp_data - repmat(TrueMean, 1, N)')'*(temp_data - repmat(TrueMean, 1, N)'))/N;  
        Variance_errors(i, iterg) = norm(TrueCovariance - loop_c_hat, 'fro')/norm(TrueCovariance, 'fro');
        
        if (i == 1)
            % For the first instance plot scatter points and best fit line
            % using PCA
            figure(plot_number);
            scatter(temp_data(:, 1), temp_data(:, 2));
            hold on;
            x1 = [-6:0.01:6];
            if(EigenValues(2,2) > EigenValues(1,1))
                eig_best = EigenVectors(:,2);
            else
                eig_best = EigenVectors(:,1);
            end
            y1 = (eig_best(2)/eig_best(1))*(x1 - TrueMean(1)) + TrueMean(2);
            plot(x1, y1, 'LineWidth', 2);
            title(sprintf('Scatter Plot for N = %d',N));
            xlabel('X coordinate');
            ylabel('Y coordinate');
            saveas(figure(plot_number), sprintf('Scatter_%d.jpg', N));
            plot_number = plot_number + 1;
        end
    end
    iterg = iterg +1;
end

% Now to plot the box plots
figure(plot_number);
subplot(2,1,1), boxplot(Mean_errors);
title('Boxplot for errors in Mean');
xlabel('log(N)');
subplot(2,1,2), boxplot(Variance_errors);
title('Boxplot for errors in Covariance');
xlabel('log(N)');
saveas(figure(plot_number), 'BoxPlots.jpg')
plot_number = plot_number + 1;
