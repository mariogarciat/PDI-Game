function [ y ] = straightLine( pjHanadle, enemyHandle, newX )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

ypj = get(pjHandle, 'YData');
xpj = get(pjHandle, 'XData');
yene = get(enemyHandle, 'YData');
xene = get(enemyHandle, 'XData');

m = (ypj(1)-yene(1))/(xpj(1)-xene(1));

yaux = yene(1);
xaux = xene(1);
b = yaux-(m*xaux);

y = (m*newX) + b;

end

