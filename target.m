function [ newFondo ] = target(fondo, targetImshow)
%TARGET Summary of this function goes here
%   Detailed explanation goes here

    r = fondo(:,:,1);
    g = fondo(:,:,2);
    b = fondo(:,:,3);
    ind = find(r<20 & g<100 & b>20);

    set(targetHandle, )

end

