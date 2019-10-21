% scales any matrix to 0,1
function [scaled] = myScale(x)
scaled = x - min(x);  
scaled = scaled / max(scaled);
end

