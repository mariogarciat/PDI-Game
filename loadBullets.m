function [ bulletsImshowOut] = loadBullets(fileRoute, numImages, numBullets)
%LOADBULLETS Summary of this function goes here
%   Detailed explanation goes here

    extension = '.png';
%     file = 'assets/enemy/bullets/bullet0';
    file = fileRoute;
    for k=1:numImages
        fullFileName = strcat(file, num2str(k));
        fullFile = strcat(fullFileName, extension);
        [bullet, bulletCM, bulletAlpha] = imread(fullFile);
        bullets{k} = {bullet, bulletCM, bulletAlpha};
    end

   
    
    for i=1:numBullets
         for k=1:numImages
            bulletsImshow{k} =imshow(bullets{1,k}{1,1});
            set(bulletsImshow{k},'AlphaData', bullets{1,k}{1,3}, 'XData', [1000], 'YData', [1000]);
        end
        bulletsImshowOut{i} = bulletsImshow;
    end

end

