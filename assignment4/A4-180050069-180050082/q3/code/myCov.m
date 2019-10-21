% given a matrix with rows as observations and columns as variabes, returns the covariance matrix
function Cov = myCov(matrix)
  [r, ~] = size(matrix);
  if(r == 1)
    Cov = var(matrix);
  else
      meanSubtractedMatrix = bsxfun(@minus, im2double(matrix), myMean(matrix));
      Cov = (meanSubtractedMatrix' * meanSubtractedMatrix)./(r-1);
  end
end