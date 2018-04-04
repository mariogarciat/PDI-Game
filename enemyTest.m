    clear all, close all, clc
fondo = imread('assets/fondo2.png');
[enemy1, enemy1CM, enemy1Alpha] = imread('assets/enemy/1.png');
[enemy3, enemy3CM, enemy3Alpha] = imread('assets/enemy/3.png');
[enemyCast1, enemyCast1CM, enemyCast1Alpha] = imread('assets/enemy/cast1.png');
[enemyCast2, enemyCast2CM, enemyCast2Alpha] = imread('assets/enemy/cast2.png');
[enemyCast3, enemyCast3CM, enemyCast3Alpha] = imread('assets/enemy/cast3.png');
[enemyCast4, enemyCast4CM, enemyCast4Alpha] = imread('assets/enemy/cast4.png');

[pj, pjCM, pjAlpha] = imread('assets/left/1.png');

%Carga balas


global bulletsImshow16 bulletsImshow5 enemyCastImshow enemyIdleImshow filenemy colenemy filfondo colfondo position2Follow;

[filfondo colfondo capfondo] = size(fondo);

%sirve para enemy1,enemy2 y enemy3
[filenemy colenemy capenemy] = size(enemy1);


f1 = figure(1); imshow(fondo,'Border','tight'); impixelinfo; hold on

enemyIdleImshow{1} = imshow(enemy1);
enemyIdleImshow{2} = imshow(enemy3);
set(enemyIdleImshow{1}, 'AlphaData', enemy1Alpha);
set(enemyIdleImshow{2}, 'AlphaData', enemy3Alpha);

enemyCastImshow{1} = imshow(enemyCast1);
enemyCastImshow{2} = imshow(enemyCast2);
enemyCastImshow{3} = imshow(enemyCast3);
enemyCastImshow{4} = imshow(enemyCast4);

set(enemyCastImshow{1},'AlphaData', enemyCast1Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{2},'AlphaData', enemyCast2Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{3},'AlphaData', enemyCast3Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{4},'AlphaData', enemyCast4Alpha, 'XData', [1000], 'YData', [1000]);

pjImshow = imshow(pj);
set(pjImshow,'AlphaData', pjAlpha, 'XData', [100], 'YData', [300]);

%Crea imshows de las balas
% for k=1:8
%     bulletsImshow{k} =imshow(bullets{1,k}{1,1});
%     set(bulletsImshow{k},'AlphaData', bullets{1,k}{1,3}, 'XData', [1000], 'YData', [1000]);
% end

% bulletsImshow16 = loadBullets(); 

bulletsImshow16 = loadBullets('assets/enemy/bullets/bullet0', 3,16); 



%%Agregar esta linea
bulletsImshow5 = loadBullets('assets/enemy/bullets/type4/', 3,5); 

hold off

positionsBullets = 0;


%%Agregar esta linea
position2Follow = [10000, 10000];



set(f1,'Units', 'normalized','MenuBar', 'none', 'Outerposition', [0, 0, 0.5, 1], 'color', 'black');
x = 0;


for i= 0:400
    
    %%Reemplazar por esta linea en el main donde pjImshow es howlImshow
    positionsBullets = attack1(i, positionsBullets, pjImshow);
    
    
    pox= get(pjImshow, 'XData');
    pox = pox(1);
    poy = get(pjImshow, 'YData');
    poy = poy(1);
    set(pjImshow, 'YData', poy-2);
    pause(0.08);
end