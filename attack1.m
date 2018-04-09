function [positionsBullets ] = attack1(i, positionsBullets, pj)
%ATTACK1 Realiza las animaciones del enemigo y de las balas, además del movimiento de las balas

    %establece las variables globales necesarias
    global bulletsImshow16 bulletsImshow5 enemyIdleImshow colfondo filfondo filenemy colenemy position2Follow;

    %vector con las posiciones iniciales de las balas en relación a la posición del enemigo.
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

    modulo = mod(i,3); %para determinar que imágen se usa.

    %este bloque realiza la animación del enemigo mediante el cambio de imágenes
    if(modulo == 0)
        set(enemyIdleImshow{2}, 'XData', [1000], 'YData', [1000]); %saca la imagen 2 del area visible

        set(enemyIdleImshow{1}, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]); %muestra en el centro de la pantalla la imagen 1
    elseif(modulo == 2)
        set(enemyIdleImshow{1}, 'XData', [1000], 'YData', [1000]); %saca la imagen 1 del area visible

        set(enemyIdleImshow{2}, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]); %muestra en el centro de la pantalla la imagen 2
    end


    %este bloque se encarga de mover las oleadas de balas y animarlas
    if(i>=30) %al tic 30 dispara la primera oleada de balas
        if(mod(i,30) == 0) %si el número del tic es múltiplo de 30 ubica las balas alrededor del enemigo
            [bulletsImshow16, positionsBullets] = initializateBulletsPosition(16, bulletsImshow16, initialPositions, colfondo/2, filfondo/2);
        end

        %este ciclo mueve las balas y va cambiando las imágenes para la animación
        for j=1:16.

            moduloAux = modulo; %moduloAux se usa para la posición en el arreglo de imshows de las balas

            bulletsImshow = bulletsImshow16{1,j}; %extrae el imshow actual
            positionsBullets(j,1) = positionsBullets(j,1)+ initialPositions(j,1)*30; %calcula la nueva posición para la bala en horizontal
            positionsBullets(j,2) = positionsBullets(j,2)+ initialPositions(j,2)*30; %calcula la nueva posición para la bala en vertical
            set(bulletsImshow{modulo+1}, 'XData', [positionsBullets(j,1)], 'YData', [positionsBullets(j,2)]); %asigna la posición nueva a siguiente imágen de la animación de la bala.
            if(modulo == 0)
                moduloAux = 3; %asigna 3 para ser el indice del arreglo.
            end
            set(bulletsImshow{moduloAux}, 'XData', [1000], 'YData', [1000]); %saca la imagen actual del area visible para generar la animación.
        end
    end



    %este bloque es para un disparo especial del enemigo
    r = floor(rand(1)*40)+10; % genera un número aleatorio para decidir si se dispara o no.
    if(mod(i, r) == 0) %decide si disparar o no en base al número aleatorio.

        bulletSpecial = 1

        %este ciclo busca entre las balas especiales cual no está en la pantalla.
        for k=1:5
            estaFuera = 1; %toma como 1= true

            %este ciclo busca entre las 3 imágenes de cada bala que todas estén fuera del area visible.
            for l=1:3
                posX = get(bulletsImshow5{1,k}{1,l}, 'XData'); %toma la posición en x de la imagen
                posX = posX(1);
                posY = get(bulletsImshow5{1,k}{1,l}, 'YData'); %toma la posición en y de la imagen
                posY = posY(1);
                if((abs(posX) < 600 && abs(posY) < 500)) %mira si ambas posiciones estan dentro del area visible
                    estaFuera = 0; % cambia la bandera.
                end
            end

            %compara con la bandera si está fuera para usarla
            if(estaFuera == 1)
                bulletSpecial = k; %toma el indice de bala que está fuera
                k = 7; %cambia la variable iteradora para salir del ciclo
            end

        end

        %
        bulletSpecial = bulletsImshow5{bulletSpecial}; %saca la bala especial a usar.
        moduloAux = modulo; %usado para el indice del arreglo de imagenes
        if(modulo == 0)
            moduloAux = 3;
        end

        sizeBullet = size(get(bulletSpecial{1,1}, 'AlphaData')); %toma el tamaño de la bala
        sizePj = size(get(pj, 'AlphaData')); %toma el tamaño del personaje
        position2Follow = [get(pj, 'XData')+(sizePj(1)/2), get(pj, 'YData')+(sizePj(2)/2)]; %toma la posicion actual del personaje para dirigir la bala a esa posicion.
        set(bulletSpecial{1,moduloAux}, 'XData', (colfondo/2)-(sizeBullet/2), 'YData', (filfondo/2)-(sizeBullet/2)); %ubica la bala cerca en el centro de la pantalla.

    end

    %este ciclo mueve las balas especiales.
    for m=1:5
        moduloAux = modulo; %se usa como indice para el arreglo de las imagenes de las balas.
        if(modulo == 0)
            moduloAux = 3;
        end

        bulletsImshow = bulletsImshow5{1,m}; %toma el imshow del arreglo para generar la animacion.
        posX = get(bulletsImshow{moduloAux}, 'XData'); %toma la posicion actual de la bala en x
        posX = posX(1);
        posY = get(bulletsImshow{moduloAux}, 'YData'); %toma la posicion actual de la bala en y
        posY = posY(1);
        if(posX(1)<1000 || posY(1)<1000) %revisa que esten en el area visible de la pantalla para moverlas.
            if(position2Follow(1) > colfondo/2) %revisa en que parte de la pantalla estaba el personaje cuando se disparo la bala
                newX = posX+25;  % aumenta la posicion en x si estaba a la derecha del enemigo
            else
                newX = posX-25;  % disminuye la posicion en x si estaba a la izquierda del enemigo
            end
            newY = straightLine(position2Follow(1), position2Follow(2), posX, posY, newX); %calcula la nueva posicion en Y para seguir una linea recta


            nextInd = modulo+1;
            set(bulletsImshow{nextInd}, 'XData', [newX], 'YData', [newY]); %asigna la nueva posicion a la siguiente imagen de la bala.


            set(bulletsImshow{moduloAux}, 'XData', [1000], 'YData', [1000]); %saca la imagen anterior de la bala del area visible.
        end
    end





end
