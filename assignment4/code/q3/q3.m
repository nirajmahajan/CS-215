clear; clc; close all;
load('points2D_Set1.mat');

dataset = [x y];

MeanCoordinate = myMean(dataset);
CovarianceMatrix = myCov(dataset);

[EigenVectors, EigenValues] = myeigs(CovarianceMatrix, 2);
eig_best = EigenVectors(:,1);

figure(1);
scatter(x,y);
hold on;
x1 = [0:0.01:1];
y1 = (eig_best(2)/eig_best(1))*(x1 - MeanCoordinate(1)) + MeanCoordinate(2);
plot(x1, y1, 'LineWidth', 2);
title('Comparison Between Dataset 1 and our Approximate');
xlabel('X coordinate');
ylabel('Y coordinate');
legend('Scatter Plot of Data', 'Estimated Linear Relation', 'Location', 'northwest');
% saveas(figure(1), 'Dataset_1.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('points2D_Set2.mat');

dataset = [x y];

MeanCoordinate = myMean(dataset);
CovarianceMatrix = myCov(dataset);

[EigenVectors, EigenValues] = myeigs(CovarianceMatrix, 2);
eig_best = EigenVectors(:,1);

figure(2);
scatter(x,y);
hold on;
x1 = [-3:0.005:3];
y1 = (eig_best(2)/eig_best(1))*(x1 - MeanCoordinate(1)) + MeanCoordinate(2);
plot(x1, y1, 'LineWidth', 2);
title('Comparison Between Dataset2 and our Approximate');
xlabel('X coordinate');
ylabel('Y coordinate');
legend('Scatter Plot of Data', 'Estimated Linear Relation', 'Location', 'northwest');
% saveas(figure(2), 'Dataset_2.jpg');

