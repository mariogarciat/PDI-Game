function [ output ] = collision( handle1,handle2 )
%COLLISION Summary of this function goes here
%   Detailed explanation goes here

    xh1 = get(handle1, 'XData');
%     xh2 = get(handle2, 'XData');
    yh1 = get(handle1, 'YData');
%     yh2 = get(handle2, 'YData');
    output = 0;
    
    for i=1:16
        for j=1:3
        xh2 = get(handle2{1,i}{1,j}, 'XData');
        yh2 = get(handle2{1,i}{1,j}, 'YData');   
        disp(yh2);
        if((xh1(2) > xh2 && xh1(1) < xh2+20) && (yh1(2)-10 > yh2 && yh1(1) < yh2+20))
            output = 1;
            disp([xh1(1) xh2 yh1(1) yh2]);
        end
        
        end
    end
    
    
end

