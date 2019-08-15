function newMedian = UpdateMedian (oldMedian, NewDataValue, A, n)
if (rem(n,2) == 0)
    if (NewDataValue >= oldMedian)
        if(NewDataValue >= A(1,(n/2)+1))
            newMedian = A(1, (n/2) + 1);
        else
            newMedian = NewDataValue;
        end
    else
        if(NewDataValue >= A(1,(n/2)))
            newMedian = NewDataValue;
        else
            newMedian = A(1,(n/2));
        end
    end
else
    if (NewDataValue >= oldMedian)
        if(NewDataValue >= A(1,((n+1)/2)+1))
            newMedian = (A(1, ((n+1)/2)) + A(1, ((n+3)/2)))/2;
        else
            newMedian = (A(1, ((n+1)/2)) + NewDataValue)/2;
        end
    else
        if(NewDataValue <= A(1,((n-1)/2)))
            newMedian = (A(1, ((n+1)/2)) + A(1, ((n-1)/2)))/2;
        else
            newMedian = (A(1, ((n+1)/2)) + NewDataValue)/2;
        end
    end
end