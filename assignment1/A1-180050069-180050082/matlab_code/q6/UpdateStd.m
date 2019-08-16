function newStd = UpdateStd (OldMean, OldStd, NewMean, NewDataValue, n)
num1 = n*(NewMean-OldMean)*(NewMean-OldMean);
num2 = (n-1)*OldStd*OldStd;
num3 = (NewMean - NewDataValue)^2;
newStd = sqrt((num1 + num2 + num3)/n);
end