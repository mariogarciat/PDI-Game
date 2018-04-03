clear all, close all, clc
fondo = imread('assets/fondo2.png');
[enemy1, enemy1CM, enemy1Alpha] = imread('assets/enemy/1.png');
[enemy2, enemy2CM, enemy2Alpha] = imread('assets/enemy/2.png');
[enemy3, enemy3CM, enemy3Alpha] = imread('assets/enemy/3.png');

%Carga balas


[filfondo colfondo capfondo] = size(fondo);

%sirve para enemy1,enemy2 y enemy3
[filenemy colenemy capenemy] = size(enemy1);


f1 = figure(1); imshow(fondo,'Border','tight'); impixelinfo; hold on
enemy1Imshow = imshow(enemy1);
set(enemy1Imshow, 'AlphaData', enemy1Alpha);
enemy3Imshow = imshow(enemy3);
set(enemy3Imshow, 'AlphaData', enemy3Alpha);

%Crea imshows de las balas
% for k=1:8
%     bulletsImshow{k} =imshow(bullets{1,k}{1,1});
%     set(bulletsImshow{k},'AlphaData', bullets{1,k}{1,3}, 'XData', [1000], 'YData', [1000]);
% end
bulletsImshow16 = loadBullets(); 

hold off

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





set(f1,'Units', 'normalized','MenuBar', 'none', 'Outerposition', [0, 0, 0.5, 1], 'color', 'black');
x = 0;

%eliminar
writerObj = VideoWriter('enemy.mp4', 'MPEG-4');
open(writerObj);

for i= 0:400
    modulo = mod(i,8);

    if(modulo == 0)
        set(enemy3Imshow, 'XData', [1000], 'YData', [1000]);
        
        set(enemy1Imshow, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
    elseif(modulo == 3)
        set(enemy1Imshow, 'XData', [1000], 'YData', [1000]);
        
        set(enemy3Imshow, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
    end
    
    if(i>50)
        if(x == 0)
            [bulletsImshow16, positionsBullets] = initializateBulletsPosition(bulletsImshow16, initialPositions, colfondo/2, filfondo/2);
            x = 1;
        end
        for j=1:16
            moduloAux = modulo;

            bulletsImshow = bulletsImshow16{1,j};
            positionsBullets(j,1) = positionsBullets(j,1)+ initialPositions(j,1)*10;
            positionsBullets(j,2) = positionsBullets(j,2)+ initialPositions(j,2)*10;
            set(bulletsImshow{modulo+1}, 'XData', [positionsBullets(j,1)], 'YData', [positionsBullets(j,2)]);
            if(modulo == 0)
                moduloAux = 8;
            end
            set(bulletsImshow{moduloAux}, 'XData', [1000], 'YData', [1000]);
        end
    end
    
    if(mod(i,50)== 0)
        x= 0;
    end
    
    frame = getframe(gcf);
    writeVideo(writerObj,frame);
    
    pause(0.08);
end
close(writerObj);