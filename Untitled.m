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

% [sprite, colorMap] = imread('assets/personaje_sprite.png');
% imshow(sprite,colorMap);


% sprite = imread('assets/personaje_sprite.png');
% imshow(sprite);


function CircCollision
% Have fun with just click
% For anr explanation or Feedback contact
% Nikesh Bajaj
% bajaj.nikkey@gmail.com  @9041150067
% Aligarh Muslim University


global vel vel2 size color1 color2 pos pos2 width hight
width=400;
hight =400;
x=(width)/2;
y=(hight)/2;

pos =[x y];
pos2=[x/2 y/2];
vel =[rand(1)+randi(7)-1 rand(1)+randi(7)-1];
vel(1)=vel(1)*(2*randi(2)-3);
vel(2)=vel(2)*(2*randi(2)-3);

vel2 =[rand(1)+randi(7)-1 rand(1)+randi(7)-1];
vel2(1)=vel2(1)*(2*randi(2)-3);
vel2(2)=vel2(2)*(2*randi(2)-3);

size =20;
color1 ='red';
color2 ='green';
figure(1)
drawcircle          %(pos,15,'red',vel,width,hight)



function drawcircle   %(pos,size,color,vel,width,hight)
global pos vel vel2 width hight size color1 color2 pos2 
disp(width)
%pause
%for i=1:1000
tic
while 1
    if pos(1)+size> width | pos(1)-size <0
        vel(1)=-(vel(1)+0.1*vel(1));
    end
    if pos(2)+size>hight | pos(2)-size<0
        vel(2)=-(vel(2)+0.1*vel(2));
    end
       
    
    if pos2(1)+size> width | pos2(1)-size <0
        vel2(1)=-vel2(1);
    end
    if pos2(2)+size>hight | pos2(2)-size<0
        vel2(2)=-vel2(2);
    end
    
    pos(1)=pos(1)+vel(1);
    pos(2)=pos(2)+vel(2);
    
    pos2(1)=pos2(1)+vel2(1);
    pos2(2)=pos2(2)+vel2(2);
    X =[ pos(1) pos2(1)];
    Y= [ pos(2),pos2(2)];
    
    plot(X(1),Y(1),'rO','Markersize',size,'MarkerFaceColor',color1)
    hold on
    plot(X(2),Y(2),'gO','Markersize',size,'MarkerFaceColor',color2)
    hold off
    axis([0, width, 0, hight])
    drawnow
    
    if pos(1) <pos2(1)+size & pos(1) >pos2(1)-size
        if pos(2) <pos2(2)+size & pos(2) >pos2(2)-size
            disp('Collision........')
            xi=(pos(1)+pos2(1))/2;
            yi=(pos(2)+pos2(2))/2;
            plot(xi,yi,'kO','Markersize',size+10,'MarkerFaceColor','black')
            axis([0, width, 0, hight])
            
        break
        end
    end
end
toc

