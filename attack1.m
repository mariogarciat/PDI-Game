function [positionsBullets ] = attack1(i, positionsBullets, pj)
%ATTACK1 Summary of this function goes here
%   Detailed explanation goes here

    global bulletsImshow16 bulletsImshow5 enemyIdleImshow colfondo filfondo filenemy colenemy position2Follow;
    
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
    
    modulo = mod(i,3);

    if(modulo == 0)
        set(enemyIdleImshow{2}, 'XData', [1000], 'YData', [1000]);
        
        set(enemyIdleImshow{1}, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
    elseif(modulo == 2)
        set(enemyIdleImshow{1}, 'XData', [1000], 'YData', [1000]);
        
        set(enemyIdleImshow{2}, 'XData', [colfondo/2-colenemy/2], 'YData', [filfondo/2-filenemy/2]);
    end
    
    if(i>=30)
        if(mod(i,30) == 0)
            [bulletsImshow16, positionsBullets] = initializateBulletsPosition(16, bulletsImshow16, initialPositions, colfondo/2, filfondo/2);
        end
        
        for j=1:16.
            
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
    
    %dispara especial
    r = floor(rand(1)*40)+10;
    if(mod(i, r) == 0)
            
        %busca especial que no esté en pantalla
        bulletSpecial = 1;

        for k=1:5
            estaFuera = 1; %1 = true
            for l=1:3
                posX = get(bulletsImshow5{1,k}{1,l}, 'XData');
                posX = posX(1);
                posY = get(bulletsImshow5{1,k}{1,l}, 'YData');
                posY = posY(1);
                if((abs(posX) < 600 && abs(posY) < 500))
                    estaFuera = 0;
                end
            end
            if(estaFuera == 1)
                bulletSpecial = k;
                k = 7;
            end
                
        end

        bulletSpecial = bulletsImshow5{bulletSpecial};
        moduloAux = modulo;
        if(modulo == 0)
            moduloAux = 3;
        end
        
        sizeBullet = size(get(bulletSpecial{1,1}, 'AlphaData'));
        sizePj = size(get(pj, 'AlphaData'));
        position2Follow = [get(pj, 'XData')+(sizePj(1)/2), get(pj, 'YData')+(sizePj(2)/2)];
        set(bulletSpecial{1,moduloAux}, 'XData', (colfondo/2)-(sizeBullet/2), 'YData', (filfondo/2)-(sizeBullet/2));
        
    end
    
    %mover especiales
    for m=1:5
        moduloAux = modulo;
        if(modulo == 0)
            moduloAux = 3;
        end        
        
        bulletsImshow = bulletsImshow5{1,m};
        posX = get(bulletsImshow{moduloAux}, 'XData');
        posX = posX(1);
        posY = get(bulletsImshow{moduloAux}, 'YData');
        posY = posY(1);
        if(posX(1)<1000 || posY(1)<1000)
            if(position2Follow(1) > colfondo/2)
                newX = posX+25;
            else
                newX = posX-25;
            end
            newY = straightLine(position2Follow(1), position2Follow(2), posX, posY, newX);
            
            
            nextInd = modulo+1;
            set(bulletsImshow{nextInd}, 'XData', [newX], 'YData', [newY]);

            
            set(bulletsImshow{moduloAux}, 'XData', [1000], 'YData', [1000]);
        end
    end
    

    
    
    
end

