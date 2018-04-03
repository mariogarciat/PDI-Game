function [pjHandle] = moveCharacter(pjHandle, direction)
%MOVEUP Summary of this function goes here
%   Detailed explanation goes here
    
    global filfondo colfondo;
    y = get(pjHandle, 'YData');
    x = get(pjHandle, 'XData');

    if(direction == 1)
        if(y(1)-30>0)
            set(pjHandle, 'YData', y-30);
        end
    elseif(direction == 2)
        if(x(1)+30<colfondo-10)
            set(pjHandle, 'XData', x+30);
        end
    elseif(direction == 3)
        if(y(1)+30<filfondo)
            set(pjHandle, 'YData', y+30);
        end
    elseif(direction == 4)
        if(x(1)-30>0)
            set(pjHandle, 'XData', x-30);
        end
    end
end

