function [pjHandle] = moveCharacter(pjHandle, direction)
%MOVECharacter Genera la nueva posición del personaje, la dirección depende
%de qué máscara haya detectado el color
%   Detailed explanation goes here
    
    global filfondo colfondo;           %variables globales filas y columnas del fondo
    
    y = get(pjHandle, 'YData');         %Obtiene la posición Y del personaje
    x = get(pjHandle, 'XData');         %Obtiene la posición X del personaje

    if(direction == 1)                  %Si la máscara superior detectó el color...
        if(y(1)-30>0)                   %Condición para que no exceda el límite superior de la pantalla
            set(pjHandle, 'YData', y-30);       %Mueve el personaje a una posición Y 30 pixeles hacia arriba
        end
    elseif(direction == 2)              %Si la máscara derecha detectó el color...
        if(x(1)+30<colfondo-10)         %Condición para que no exceda el límite derecho de la pantalla
            set(pjHandle, 'XData', x+30);       %Mueve el personaje a una posición Y 30 pixeles hacia la derecha
        end
    elseif(direction == 3)              %Si la máscara inferior detectó el color...
        if(y(1)+30<filfondo)            %Condición para que no exceda el límite inferior de la pantalla
            set(pjHandle, 'YData', y+30);       %Mueve el personaje a una posición Y 30 pixeles hacia abajo
        end
    elseif(direction == 4)              %Si la máscara izquierda detectó el color...
        if(x(1)-30>0)                   %Condición para que no exceda el límite izquierdo de la pantalla
            set(pjHandle, 'XData', x-30);       %Mueve el personaje a una posición Y 30 pixeles hacia la izquierda
        end
    end
end

