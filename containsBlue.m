function [out] = containsBlue(image)
%CONTAINSBLUE Summary of this function goes here
%   Detailed explanation goes here
    r = image(:,:,1);
    g = image(:,:,2);
    b = image(:,:,3);
    ind = find(r<30 & g<30 & b>100);

    if(ind~=0)
       out = 1; 
    else
        out = 0;
    end
    
end

