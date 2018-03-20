% figure1 = figure;
% ax1 = axes('Parent',figure1);
% ax2 = axes('Parent',figure1);
% set(ax1,'Visible','off');
% set(ax2,'Visible','off');
% [a,map,alpha] = imread('wea.png');
% I = imshow(a,'Parent',ax2);
% set(I,'AlphaData',alpha);
% imshow('fondo.jpg','Parent',ax1);
clear all, close all, clc

% C = {[1,2;3,4],[5,6;7,8],[9,10;11,12],[13,14;15,16]};
% a = C;
% num = numel(C);
% szr = cellfun('size',C,1);
% szc = cellfun('size',C,2);
% csr = cumsum([0,szr-1]);
% csc = cumsum([0,szc-1]);
% M = zeros(1+csr(end),1+csc(end));
% for k = 1:num
%   idr = csr(k)+(1:szr(k));
%   idc = csc(k)+(1:szc(k));
%   M(idr,idc) = C{k};
% end

[sprite, colorMap] = imread('assets/personaje_sprite.png');
imshow(sprite,colorMap);


% sprite = imread('assets/personaje_sprite.png');
% imshow(sprite);