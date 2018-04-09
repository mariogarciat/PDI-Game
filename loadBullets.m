function [ bulletsImshowOut] = loadBullets(fileRoute, numImages, numBullets)
%LOADBULLETS Carga las imágenes de las balas, cuando estas tienen unformato de tipo.
% img01, img02, img03...etc

    extension = '.png'; %extensión de las imágenes.

    %Este bloque crea la dirección de las imágenes y las carga a memoria.
    file = fileRoute; %dirección hasta el nombre de la imágen sin la numeración.
    for k=1:numImages
        fullFileName = strcat(file, num2str(k)); %añade el número a la dirección.
        fullFile = strcat(fullFileName, extension); %añade la extensión del archivo.
        [bullet, bulletCM, bulletAlpha] = imread(fullFile); %carga la imagen con los datos de esta.
        bullets{k} = {bullet, bulletCM, bulletAlpha}; %va creando un arreglo con los datos de cada imágen.
    end


    %Este bloque crea el número de imshows en pantalla según el número de balas requeridas.

    %El ciclo interno es para crear copias de los imshows del anterior ciclo
    %El ciclo externo es para crear el número de balas entradas por parámetro
    for i=1:numBullets
         for k=1:numImages
            bulletsImshow{k} =imshow(bullets{1,k}{1,1}); %crea la copia de cada imagen de la animacion de la bala
            set(bulletsImshow{k},'AlphaData', bullets{1,k}{1,3}, 'XData', [1000], 'YData', [1000]); %posiciona cada imagen en un lugar no visble de la pantalla
        end
        bulletsImshowOut{i} = bulletsImshow; %guarda la copia de cada imágen en un arreglo en el que cada posición es una bala.
    end

end
