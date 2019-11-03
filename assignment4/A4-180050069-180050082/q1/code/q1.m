rng(1);
%code for N = 10, 100, ...., 10^8
for N=[10 10^2 10^3 10^4 10^5 10^6 10^7 10^8] 
   count = 0;
   sample_set = 2*rand(2,N)-1;
   sample_set = single(sample_set);
   for j=1:N 
        x1 = sample_set(1,j);
        x2 = sample_set(2,j);

        value = x1^2 + x2^2;
        if value<1
            count = count + 1;
        end
   end
   fprintf('Estimated pi = ');
   disp(4*count/N);
end
%code for 10^9 given below
count_new = 0;

for i=1:1000
    for j=1:10^6
        x1 = 2*rand()-1;
        x2 = 2*rand()-1;
        
        value1 = x1^2 + x2^2;
        if value1<1
            count_new = count_new+1;
        end
    end
end
fprintf('Estimated pi = ');
disp(4*count_new/10^9);
    