clear; clc; close all;
load('mnist.mat');
plot_number = 1;
sorted_train_data = cell(1, 10);

for iter = [1:60000]
    label = labels_train(iter);
    data = im2double(reshape(digits_train(:, :, iter), 1, 784));
    if (label == 0)
        label = 10;
    end
    sorted_train_data{label} = [sorted_train_data{label}; data];
end

MeanVectors = cell(1,10);
CovarianceMatrices = cell(1,10);
MaxEigenValues = cell(1,10);
FirstModesOfVariation = cell(1,10);
for iter = [0:9]
    index = iter;
    if(iter == 0)
        index = 10;
    end
    temp_mean = myMean(sorted_train_data{index});
    MeanVectors{index} = temp_mean;
    temp_cov = myCov(sorted_train_data{index});
    CovarianceMatrices{index} = temp_cov;
    [EigenVects, EigenVals] = eig(temp_cov);
    [MaxVal, Index] = max(diag(EigenVals));
    MaxEigenValues{index} = MaxVal;
    FirstModesOfVariation{index} = EigenVects(:, Index);
    
    % plotting eigenvalues;
    figure(plot_number);
    subplot(1,2,1), plot([1:784], (-sort(-diag(EigenVals))), 'r-o');
    title(sprintf('Eigenvalues for %d', rem(index,10)));
    xlabel('components');
    ylabel('eigenvalues');
    
    subplot(1,2,2), semilogx([1:784], (-sort(-diag(EigenVals))), 'r-o');
    title(sprintf('Eigenvalues on a log scale'));
    xlabel('components(log scale)');
    ylabel('eigenvalues');
    saveas(figure(plot_number), sprintf('Eigen_%d.jpg', rem(index,10)));
    plot_number = plot_number+1;
   
    
    % print three types of means
    figure(plot_number);
    additional_term = sqrt(MaxVal)*FirstModesOfVariation{index}';
    subplot(1,3,1), imagesc(reshape((temp_mean-additional_term), 28,28));
    title('\mu - \surd{\lambda}v');
    subplot(1,3,2), imagesc(reshape(temp_mean, 28,28));
    xlabel(sprintf('Analysis for the digit %d', rem(index, 10)));
    title('\mu');
    subplot(1,3,3), imagesc(reshape((temp_mean+additional_term), 28,28));
    title('\mu + \surd{\lambda}v');
    saveas(figure(plot_number), sprintf('Comparison_mu_%d.jpg', rem(index,10)));
    plot_number = plot_number+1;
    
end

save('results', 'MeanVectors', 'CovarianceMatrices', 'MaxEigenValues', 'FirstModesOfVariation');