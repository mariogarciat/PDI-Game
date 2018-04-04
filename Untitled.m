clear all, close all, clc

cam = imaq.VideoDevice('winvideo', 1);
step(cam);
shot = step(cam);
shot = uint8(shot*255);
[target, targetColorMap, targetAlpha] = imread('assets/more/1.png');
targetImshow = imshow(target);
set(targetImshow, 'AlphaData', targetAlpha, 'XData', 1000, 'YData', 1000);

% fondo = imread('assets/fondo2.png');
figure(1);imshow(shot); impixelinfo
r = shot(:,:,1);
g = shot(:,:,2);
b = shot(:,:,3);
masc = shot*0;
ind = find(r<40 & g>100 & b<60);
f = size(ind);
% if(ind ~= 0)
%     for i=ind(1):f
%        masc(i) 
%     end
% end
masc(ind) = 150;
figure(2);imshow(masc);

release(cam);
