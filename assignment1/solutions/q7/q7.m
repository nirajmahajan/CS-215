clear;clc;
p = [5, 10, 15, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 99.99, 99.9999, 100];

ans = [1];
ans(1)=[];

for elem = p
    if(p <= 0)
        ans = [ans 0];
        continue;
    end
    n=3;
    frac = (100*365*364)/(365*365);
    to_mult = 363;
    
    while frac > 100-elem
        n = n+1;
        if(to_mult == 0)
            break;
        end
        frac = (frac * to_mult)/365;
        to_mult = to_mult - 1;
    end
    ans = [ans n-1];
end

ans

plot(p, ans);
title('plot of n vs p');
xlabel('probability');
ylabel('minimum number of students');