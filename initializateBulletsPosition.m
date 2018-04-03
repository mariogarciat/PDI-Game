function [ bulletsImshow16, initialPositions ] = initializateBulletsPosition( bulletsImshow16, initialPositions, centerX, centerY )
%INITIALIZATEBULLETSPOS Summary of this function goes here
%   Detailed explanation goes here

    
    

    for i=1:16
        sizeBullet = size(get(bulletsImshow16{1,1}{1,1}, 'AlphaData'));
        initialPositions(i,1) = centerX + initialPositions(i,1) - sizeBullet(1)/2;
        initialPositions(i,2) = centerY + initialPositions(i,2) - sizeBullet(1)/2;
        set(bulletsImshow16{1,i}{1,1}, 'XData', [initialPositions(i,1)], 'YData', initialPositions(i,2));
        
    end

end
