% Returns the top k eigen values of a matrix in the sorted descending
% order. Builds on the standard eigs function

function [V, D] = myeigs(matrix, k)
    [V1, D1] = eigs(matrix, k);
    D=diag(sort(diag(D1),'descend'));
    [~, ind]=sort(diag(D1),'descend');
    V=V1(:,ind);
    
end

