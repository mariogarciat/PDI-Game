function [out] = containsBlue(image)
%CONTAINSBLUE Analiza la máscara que se le envía como parámetro y devuelve
%1 en caso de que hay color azul, 0 de lo contrario.
%   Detailed explanation goes here
    r = image(:,:,1);               %Obtiene la capa red de la imagen
    g = image(:,:,2);               %Obtiene la capa green de la imagen
    b = image(:,:,3);               %Obtiene la capa blue de la imagen
    
    ind = find(r<30 & g<30 & b>100);    %Obtiene un vector ind con las posiciones de la matriz que cumplan las condiciones escritas

    if(ind~=0)                      %Analiza si el vector ind no tiene tiene todos sus valores cero 
       out = 1;                     %Si se cumple lo anterior out = 1
    else                            
        out = 0;                    %out = 0, en caso contrario
    end
end

