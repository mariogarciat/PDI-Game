function [pjHandle] = moveCharacter(pjHandle, direction)
%MOVECharacter Genera la nueva posici�n del personaje, la direcci�n depende
%de qu� m�scara haya detectado el color
%   Detailed explanation goes here
    
    global filfondo colfondo;           %variables globales filas y columnas del fondo
    
    y = get(pjHandle, 'YData');         %Obtiene la posici�n Y del personaje
    x = get(pjHandle, 'XData');         %Obtiene la posici�n X del personaje

    if(direction == 1)                  %Si la m�scara superior detect� el color...
        if(y(1)-30>0)                   %Condici�n para que no exceda el l�mite superior de la pantalla
            set(pjHandle, 'YData', y-30);       %Mueve el personaje a una posici�n Y 30 pixeles hacia arriba
        end
    elseif(direction == 2)              %Si la m�scara derecha detect� el color...
        if(x(1)+30<colfondo-10)         %Condici�n para que no exceda el l�mite derecho de la pantalla
            set(pjHandle, 'XData', x+30);       %Mueve el personaje a una posici�n Y 30 pixeles hacia la derecha
        end
    elseif(direction == 3)              %Si la m�scara inferior detect� el color...
        if(y(1)+30<filfondo)            %Condici�n para que no exceda el l�mite inferior de la pantalla
            set(pjHandle, 'YData', y+30);       %Mueve el personaje a una posici�n Y 30 pixeles hacia abajo
        end
    elseif(direction == 4)              %Si la m�scara izquierda detect� el color...
        if(x(1)-30>0)                   %Condici�n para que no exceda el l�mite izquierdo de la pantalla
            set(pjHandle, 'XData', x-30);       %Mueve el personaje a una posici�n Y 30 pixeles hacia la izquierda
        end
    end
end

