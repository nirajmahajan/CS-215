% Function to calculate mean of a matrix
function Mean = myMean(a)
  [r, ~] = size(a);
  Mean = sum(a)/r;
end