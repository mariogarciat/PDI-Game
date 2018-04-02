function [ output ] = collision( handle1,handle2 )
%COLLISION Summary of this function goes here
%   Detailed explanation goes here

    xh1 = get(handle1, 'XData');
    xh2 = get(handle2, 'XData');
    yh1 = get(handle1, 'YData');
    yh2 = get(handle2, 'YData');
    output = 0;
    if((xh1(1) < xh2(1)+30 && xh1(1) > xh2(1)) && (yh1(1) < yh2(1)+30 && yh1(1) > yh2(1)))
        output = 1;
%         if (yh1(1) < yh2(1)+30 && yh1(1) > yh2(1))
%             
%         end
    end
    

end

