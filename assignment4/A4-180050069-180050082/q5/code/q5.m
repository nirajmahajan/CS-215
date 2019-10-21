clear; clc; close all;
rng(169);
plot_number = 1;
fruit_data_cell = cell(16,1);

for iter = [1:16]
    fruit_path = sprintf('data_fruit/image_%d.png', iter);
    data = reshape(im2double(imread(fruit_path)), 1, 19200);
    fruit_data_cell{iter} = data;
end
fruit_data = cell2mat(fruit_data_cell);
MeanFruit = myMean(fruit_data);

% Fruit_Covariance = myCov(fruit_data);
load('CovMatrix.mat'); % Pre computed covariance matrix using the above line of code
% save('CovMatrix', 'Fruit_Covariance', '-v7.3') 

[EigenVectors, EigenValues] = myeigs(Fruit_Covariance, 10);
EigenValues = diag(EigenValues);
EigenVectors4 = EigenVectors(:, [1:4]);
EigenValues4 = EigenValues([1:4]);

figure(plot_number);
temp = MeanFruit;
subplot(3,2,1), image(reshape(myScale(temp), 80, 80, 3));
title('Mean Fruit')
temp = EigenVectors4(:, 1);
subplot(3,2,3), image(reshape(myScale(temp), 80, 80, 3));
title('1st eigenvector')
temp = EigenVectors4(:, 2);
subplot(3,2,4), image(reshape(myScale(temp), 80, 80, 3));
title('2nd eigenvector')
temp = EigenVectors4(:, 3);
subplot(3,2,5), image(reshape(myScale(temp), 80, 80, 3));
title('3rd eigenvector')
temp = EigenVectors4(:, 4);
subplot(3,2,6), image(reshape(myScale(temp), 80, 80, 3));
title('4th eigenvector')
% saveas(figure(plot_number), 'Mean_and_4Eigen.jpg');
plot_number = plot_number+1;

figure(plot_number);
plot([1:10], EigenValues, 'r-o');
title('Top 10 eigenvalues of the data');
xlabel('components');
ylabel('eigenvalues');
% saveas(figure(plot_number), 'Eigen10.jpg');
plot_number = plot_number+1;

for iter = [1:16]
    v1 = EigenVectors4(:,1);
    v2 = EigenVectors4(:,2);
    v3 = EigenVectors4(:,3);
    v4 = EigenVectors4(:,4);
    a1 = (fruit_data_cell{iter}*v1 - MeanFruit*v1)/(v1'*v1);
    a2 = (fruit_data_cell{iter}*v2 - MeanFruit*v2)/(v2'*v2);
    a3 = (fruit_data_cell{iter}*v3 - MeanFruit*v3)/(v3'*v3);
    a4 = (fruit_data_cell{iter}*v4 - MeanFruit*v4)/(v4'*v4);
    approx_fruit = MeanFruit' + a1*v1 + a2*v2 + a3*v3 + a4*v4;
    
    figure(plot_number);
    subplot(1,2,1), image(reshape(myScale(fruit_data_cell{iter}), 80, 80, 3));
    title(sprintf('Orignal Fruit(image%d)', iter));
    subplot(1,2,2), image(reshape(myScale(approx_fruit), 80, 80, 3));
    title(sprintf('Closest Fruit'));
%     saveas(figure(plot_number), sprintf('Closest_fruit_analysis_%d.jpg', iter));
    plot_number = plot_number+1;
end

for iter = [1:3]
    v1 = EigenVectors4(:,1);
    v2 = EigenVectors4(:,2);
    v3 = EigenVectors4(:,3);
    v4 = EigenVectors4(:,4);
    a1 = sqrt(EigenValues(1))*randn(1);
    a2 = sqrt(EigenValues(2))*randn(1);
    a3 = sqrt(EigenValues(3))*randn(1);
    a4 = sqrt(EigenValues(4))*randn(1);
    new_fruit = MeanFruit' + a1*v1 + a2*v2 + a3*v3 + a4*v4;
    
    figure(plot_number);
    image(reshape(myScale(new_fruit), 80, 80, 3));
    title(sprintf('New Fruit(Number %d)', iter));
%     saveas(figure(plot_number), sprintf('New_Fruit_Creation_%d.jpg', iter));
    plot_number = plot_number+1;
end
