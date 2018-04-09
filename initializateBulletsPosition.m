function [ bulletsImshow, initialPositions ] = initializateBulletsPosition(numBullets, bulletsImshow, initialPositions, centerX, centerY )
%INITIALIZATEBULLETSPOS Crea los objetos imshow necesarios para mostrar las balas en pantalla.


    %Este ciclo ubica las balas alrededor del enemigo
    for i=1:numBullets
        sizeBullet = size(get(bulletsImshow{1,1}{1,1}, 'AlphaData')); %toma el tamaño de la bala
        initialPositions(i,1) = centerX + initialPositions(i,1) - sizeBullet(1)/2; %toma el centro de la pantalla y calcula la posición horizontalmente
        initialPositions(i,2) = centerY + initialPositions(i,2) - sizeBullet(1)/2; %toma el centro de la pantalla y calcula la posición verticalmente
        set(bulletsImshow{1,i}{1,1}, 'XData', [initialPositions(i,1)], 'YData', initialPositions(i,2)); %asigna la posición a la bala.

    end

end
