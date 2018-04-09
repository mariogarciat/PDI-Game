function [ output ] = collision( handle1,handle2 )
%COLLISION Compara si el personaje y alguna de las balas se encuentran en posiciones "similares",
%significando esto que hay una colisi�n entre los objetos

    xh1 = get(handle1, 'XData');        %Obtiene la posici�n X del personaje
    yh1 = get(handle1, 'YData');        %Obtiene la posici�n Y del personaje
    
    output = 0;                         %Inicializa output = 1
    
    for i=1:16                          %Ciclo a 16 iteraciones, el n�mero de balas en cada oleada
        for j=1:3                       %Segundo ciclo a 3 iteraciones, el n�mero de im�genes por bala, generando la animaci�n de esta
        xh2 = get(handle2{1,i}{1,j}, 'XData');      %Obtiene la posici�n X de la i-�sima bala en sus tres im�genes
        yh2 = get(handle2{1,i}{1,j}, 'YData');      %Obtiene la posici�n Y de la i-�sima bala en sus tres im�genes

        if((xh1(2) > xh2 && xh1(1) < xh2+20) && (yh1(2)-10 > yh2 && yh1(1) < yh2+20))   %Establece una zona de colisi�n para el personaje y las balas
            output = 1;                 %Output se hace 1 si la zona de colisi�n es alcanzada entre ambos objetos
        end
        end
    end
end

