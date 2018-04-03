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


global filfondo colfondo;
[filfondo colfondo capfondo] = size(fondo);
[filhowl colhowl caphowl] = size(howl);
[filenemy colenemy capenemy] = size(enemy);

f1 = figure(1); imshow(fondo, 'Border','tight'); impixelinfo; hold on
howlImshow = imshow(howl); 
enemy1Imshow = imshow(enemy);
enemy3Imshow = imshow(enemy3);
targetImshow = imshow(taget);


bulletsImshow16 = loadBullets();

hold off

set(f1,'Units', 'normalized','MenuBar', 'none', 'Outerposition', [0, 0, 0.5, 1], 'color', 'black');
set(howlImshow, 'AlphaData', howlAlpha);
set(enemy1Imshow, 'AlphaData', enemyAlpha, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
set(enemy3Imshow, 'AlphaData', enemy3Alpha, 'XData', 1000, 'YData', 1000);
set(targetImshow, 'AlphaData', enemy3Alpha, 'XData', 1000, 'YData', 1000);

initialPositions = [
        1 0;
        0.9272 0.3746;
        0.7071 0.7071;
        0.3907 0.9205;
        0 1;
        -0.3907 0.9205;
        -0.7071 0.7071;
        -0.9272 0.3746;
        -1 0;
        -0.9272 -0.3746;
        -0.7071 -0.7071;
        -0.3907 -0.9205;
        0 -1;
        0.3907 -0.9205;
        0.7071 -0.7071;
        0.9272 -0.3746
    ];

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

ind = find(masc1==0 & masc2==0 & masc3==0 & masc4==0); %encuentra los �ndices donde la matriz es cero, en este caso, todo negro menos las m�scaras
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
     
     aux1(ind1) = snap(ind1);
     aux2(ind2) = snap(ind2);
     aux3(ind3) = snap(ind3);
     aux4(ind4) = snap(ind4);
     blue1 = containsBlue(aux1);
     blue2 = containsBlue(aux2);
     blue3 = containsBlue(aux3);
     blue4 = containsBlue(aux4);
     ifcollision = collision(howlImshow, enemy1Imshow); 
     
     if(ifcollision == 1)
             disp('has perdidoooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
             break;
     else
         if(blue1 == 1)
            howlImshow = moveCharacter(howlImshow, 1, enemy1Imshow);
            disp('arriba');
         end
         if(blue2 == 1)
             howlImshow = moveCharacter(howlImshow, 2, enemy1Imshow);
             disp('derecha');
         end     
         if(blue3 == 1)
             howlImshow = moveCharacter(howlImshow, 3, enemy1Imshow);
             disp('abajo');
         end
         if(blue4 == 1)
             howlImshow = moveCharacter(howlImshow, 4, enemy1Imshow);
             disp('izquierda');
         end     
         pause(0.01);
     end
    modulo = mod(i,3);

    if(modulo == 0)
        set(enemy3Imshow, 'XData', [1000], 'YData', [1000]);
        
        set(enemy1Imshow, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
    elseif(modulo == 3)
        set(enemy1Imshow, 'XData', [1000], 'YData', [1000]);
        
        set(enemy3Imshow, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
    end
    
    if(i>30)
        if(x == 0)
            [bulletsImshow16, positionsBullets] = initializateBulletsPosition(bulletsImshow16, initialPositions, colfondo/2, filfondo/2);
            x = 1;
        end
        for j=1:16
            moduloAux = modulo;

            bulletsImshow = bulletsImshow16{1,j};
            positionsBullets(j,1) = positionsBullets(j,1)+ initialPositions(j,1)*30;
            positionsBullets(j,2) = positionsBullets(j,2)+ initialPositions(j,2)*30;
            set(bulletsImshow{modulo+1}, 'XData', [positionsBullets(j,1)], 'YData', [positionsBullets(j,2)]);
            if(modulo == 0)
                moduloAux = 3;
            end
            set(bulletsImshow{moduloAux}, 'XData', [1000], 'YData', [1000]);
        end
    end
    
    if(mod(i,30)== 0)
        x= 0;
    end
     snap(ind) = fondo(ind);
     
     step(hVideoIn,snap);

end
release(cam);






