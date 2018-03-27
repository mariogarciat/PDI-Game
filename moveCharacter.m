function [pjHandle] = moveCharacter(pjHandle, direction)
%MOVEUP Summary of this function goes here
%   Detailed explanation goes here
    

    y = get(pjHandle, 'YData');
    x = get(pjHandle, 'XData');

    if(direction == 1)
        set(pjHandle, 'YData', y-30);
    elseif(direction == 2)
        set(pjHandle, 'XData', x+30);
    elseif(direction == 3)
        set(pjHandle, 'YData', y+30);
    elseif(direction == 4)
        set(pjHandle, 'XData', x-30);
    end
    
end

