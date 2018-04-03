function [positionsBullets] = attack1(i, enemyEspecial, positionsBullets)
%ATTACK1 Summary of this function goes here
%   Detailed explanation goes here

    global bulletsImshow16 enemyIdleImshow colfondo filfondo filenemy colenemy;
    
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
    
end

