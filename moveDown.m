function [image, newy] = moveDown(scene, char, y)
%MOVEUP Summary of this function goes here
%   Detailed explanation goes here
    
    y = y+50;
    image = scene;
    image((1:size(char,1))+y, (1:size(char,2)), :) = char;
    newy = y;
    disp(y); 
end

