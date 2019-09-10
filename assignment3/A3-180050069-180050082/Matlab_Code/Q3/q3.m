clear;clc;
Data = dlmread('XYZ.txt', ',');
X = Data(:,1);
Y = Data(:,2);
Z = Data(:,3);

N_data = length(Data);

XX = sum(X.*X);
XY = sum(X.*Y);
YY = sum(Y.*Y);
XZ = sum(X.*Z);
YZ = sum(Y.*Z);
Xs = sum(X);
Ys = sum(Y);
Zs = sum(Z);


syms a b c
eqn1 = XX*a + XY*b + Xs*c == XZ;
eqn2 = XY*a + YY*b + Ys*c == YZ;
eqn3 = Xs*a + Ys*b + N_data*c == Zs;

[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [a,b,c]);

ANS = linsolve(A,B);

a=double(ANS(1));
b=double(ANS(2));
c=double(ANS(3));

fprintf('The equation of the plane is ax + by + c = Z, where \n');
fprintf('a = %f\n',a);
fprintf('b = %f\n',b);
fprintf('c = %f\n',c);
fprintf('Predicted Noise Variance = %f\n', var(Z-a*X-b*Y-c));