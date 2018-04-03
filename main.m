clear all, close all, clc

cam = imaq.VideoDevice('winvideo', 1);
vidInfo = imaqhwinfo(cam);
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ...
                                'Position', [640 1 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);

[howl, howlColorMap, howlAlpha] = imread('assets/down right/1.png');
howl = imresize(howl, 0.5); howlAlpha = imresize(howlAlpha, 0.5);
fondo = imread('assets/fondo2.png'); fondo = imresize(fondo, 1.5);
fondo2 = fondo;
[enemy, enemyColorMap, enemyAlpha] = imread('assets/enemy/1.png');
[enemy3, enemy3CM, enemy3Alpha] = imread('assets/enemy/3.png');
[target, targetColorMap, targetAlpha] = imread('assets/more/1.png');
[enemyCast1, enemyCast1CM, enemyCast1Alpha] = imread('assets/enemy/cast1.png');
[enemyCast2, enemyCast2CM, enemyCast2Alpha] = imread('assets/enemy/cast2.png');
[enemyCast3, enemyCast3CM, enemyCast3Alpha] = imread('assets/enemy/cast3.png');
[enemyCast4, enemyCast4CM, enemyCast4Alpha] = imread('assets/enemy/cast4.png');




global bulletsImshow16 enemyCastImshow enemyIdleImshow filenemy colenemy filfondo colfondo;
[filfondo colfondo capfondo] = size(fondo);
[filhowl colhowl caphowl] = size(howl);
[filenemy colenemy capenemy] = size(enemy);

f1 = figure(1); imshow(fondo, 'Border','tight'); impixelinfo; hold on
howlImshow = imshow(howl); 
targetImshow = imshow(target);
enemyIdleImshow{1} = imshow(enemy);
enemyIdleImshow{2} = imshow(enemy3);
set(enemyIdleImshow{1}, 'AlphaData', enemyAlpha);
set(enemyIdleImshow{2}, 'AlphaData', enemy3Alpha);

enemyCastImshow{1} = imshow(enemyCast1);
enemyCastImshow{2} = imshow(enemyCast2);
enemyCastImshow{3} = imshow(enemyCast3);
enemyCastImshow{4} = imshow(enemyCast4);

bulletsImshow16 = loadBullets('assets/enemy/bullets/bullet0', 3,16); 

hold off

enemyEspecial = 0;
positionsBullets = 0;

set(f1,'Units', 'normalized','MenuBar', 'none', 'Outerposition', [0, 0, 0.5, 1], 'color', 'black');
set(howlImshow, 'AlphaData', howlAlpha);
set(targetImshow, 'AlphaData', enemy3Alpha, 'XData', 1000, 'YData', 1000);
set(enemyCastImshow{1},'AlphaData', enemyCast1Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{2},'AlphaData', enemyCast2Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{3},'AlphaData', enemyCast3Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{4},'AlphaData', enemyCast4Alpha, 'XData', [1000], 'YData', [1000]);

step(cam);
shot = step(cam);
     
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
     snap = step(cam);
     snap = flip(snap,2);
     snap = uint8(snap*255);

     positionsBullets = attack1(i, enemyEspecial, positionsBullets);
     aux1(ind1) = snap(ind1);
     aux2(ind2) = snap(ind2);
     aux3(ind3) = snap(ind3);
     aux4(ind4) = snap(ind4);
     blue1 = containsBlue(aux1);
     blue2 = containsBlue(aux2);
     blue3 = containsBlue(aux3);
     blue4 = containsBlue(aux4);
     ifcollision = collision(howlImshow, enemyIdleImshow{1}); 
     
     if(ifcollision == 1)
             disp('has perdidoooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
             break;
     else
         if(blue1 == 1)
            howlImshow = moveCharacter(howlImshow, 1);
            disp('arriba');
         end
         if(blue2 == 1)
             howlImshow = moveCharacter(howlImshow, 2);
             disp('derecha');
         end     
         if(blue3 == 1)
             howlImshow = moveCharacter(howlImshow, 3);
             disp('abajo');
         end
         if(blue4 == 1)
             howlImshow = moveCharacter(howlImshow, 4);
             disp('izquierda');
         end     
         pause(0.01);
     end
    
     snap(ind) = fondo(ind);
     
     step(hVideoIn,snap);

end
release(cam);






