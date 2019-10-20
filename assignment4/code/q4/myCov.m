% given a matrix with rows as observations and columns as variabes, returns the covariance matrix
function Cov = myCov(matrix)
  [~, c] = size(matrix);
  meanSubtractedMatrix = bsxfun(@minus, matrix, myMean(matrix));
  Cov = zeros(c);
  for i = [1:c]
    for j = [1:c]
      Cov(i, j) = meanSubtractedMatrix(:, i)'*meanSubtractedMatrix(:,j);
    end
  end
  Cov = Cov/2;
end