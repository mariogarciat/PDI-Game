clear all, close all, clc
cam = videoinput('winvideo');



% % % cam2 = imaq.VideoDevice('winvideo', 1);
% % % vidInfo = imaqhwinfo(cam2);
% % % hVideoIn = vision.VideoPlayer('Name', 'Final Video', ...
%                                 'Position', [60+vidInfo.MaxWidth 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);


triggerconfig(cam,'manual');
set(cam,'TimerPeriod',0.3);
[howl, howlColorMap, howlAlpha] = imread('assets/down right/1.png');
fondo = imread('fondo.jpg'); 
fondo2 = fondo;
[enemy, enemyColorMap, enemyAlpha] = imread('assets/death/1.png');

[filfondo colfondo capfondo] = size(fondo);
[filhowl colhowl caphowl] = size(howl);
[filenemy colenemy capenemy] = size(enemy);

f1 = figure(1); imshow(fondo); impixelinfo; hold on
howlImshow = imshow(howl); 
enemyImshow = imshow(enemy); hold off

set(f1,'Units', 'normalized','Outerposition', [0, 0, 0.5, 1]);
set(howlImshow, 'AlphaData', howlAlpha);
%figure(2); imshow(up1); 
%set(gcf, 'Units', 'normalized', 'Outerposition',
%[0.5, 0, 0.5, 1]);   cámara
set(enemyImshow, 'AlphaData', enemyAlpha, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);


% % % videoPlayer = vision.VideoPlayer;
% % % videoFReader = vision.VideoFileReader('fundido.avi');

% colshift = 50;
% rowshift = 30;
% fondo((1:size(howl,1))+rowshift, (1:size(howl,2))+colshift, :) = howl;
% fondo((1:size(enemy,1))+(filfondo/2-filenemy/2), (1:size(enemy,2))+(colfondo/2-colenemy/2), :) = enemy;
% fondo2((1:size(enemy,1))+(filfondo/2-filenemy/2), (1:size(enemy,2))+(colfondo/2-colenemy/2), :) = enemy;



% indhowl = size(howl);
% fondo(indhowl) = howl(indhowl);
%imshow(fondo);
scene = fondo2;
    
start(cam);
shot = getsnapshot(cam);

% % % step(cam);
% % % shot = step(cam2);


% f2 = figure(2); 
% imshow(shot);
% set(f2, 'Units', 'normalized', 'Outerposition',[0.5, 0, 0.5, 1]); %  cámara
 
     
masc1 = shot*0;
masc2 = shot*0;
masc3 = shot*0;
masc4 = shot*0;
[fil,col,cap] = size(shot);     
masc1(1:fil*1/3,col*1/3:col*2/3,:) = 150;
masc2(fil*2/9:fil*7/9,col*3/4:col,:) = 150;
masc3(fil*2/3:fil,col*1/3:col*2/3,:) = 150;
masc4(fil*2/9:fil*7/9,1:col*1/4,:) = 150;

ind = find(masc1==0 & masc2==0 & masc3==0 & masc4==0); %encuentra los índices donde la matriz es cero, en este caso, todo negro menos las máscaras
ind1 = find(masc1~=0);
ind2 = find(masc2~=0);
ind3 = find(masc3~=0);
ind4 = find(masc4~=0);

aux1 = masc1;
aux2 = masc2;
aux3 = masc3;
aux4 = masc4;

fondo = imresize(fondo, [fil,col]);

for i=1:1000
% % %      snap = step(cam);
     snap = peekdata(cam, 1);
     snap = flip(snap,2);
     
     aux1(ind1) = snap(ind1);
     aux2(ind2) = snap(ind2);
     aux3(ind3) = snap(ind3);
     aux4(ind4) = snap(ind4);
     blue1 = containsBlue(aux1);
     blue2 = containsBlue(aux2);
     blue3 = containsBlue(aux3);
     blue4 = containsBlue(aux4);
     ifcollision = collision(howlImshow, enemyImshow); 
     
     if(ifcollision == 1)
             disp('has perdidoooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
             break;
     else
         if(blue1 == 1)
            howlImshow = moveCharacter(howlImshow, 1, enemyImshow);
            disp('arriba');
         end
         if(blue2 == 1)
             howlImshow = moveCharacter(howlImshow, 2, enemyImshow);
             disp('derecha');
         end     
         if(blue3 == 1)
             howlImshow = moveCharacter(howlImshow, 3, enemyImshow);
             disp('abajo');
         end
         if(blue4 == 1)
             howlImshow = moveCharacter(howlImshow, 4, enemyImshow);
             disp('izquierda');
         end     
         pause(0.01);
     end
     
     
     snap(ind) = fondo(ind);
     
     
% % %      vidIn = step(cam);
     
% % %      f2 = figure(2); step(hVideoIn,shot2);
% % %      set(f2, 'Units', 'normalized', 'Outerposition',[0.5, 0, 0.5, 1]); %  cámara
%      preview(cam);impixelinfo
%      imshow(snap); 

%      
     
         
     
end
stop(cam);




