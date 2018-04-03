clear all, close all, clc


ypj = get(pjHandle, 'YData');
xpj = get(pjHandle, 'XData');
yene = get(enemyhandle, 'YData');
xene = get(enemyhandle, 'XData');

m = (ypj(1)-yene(1))/(xpj(1)-xene(1));

y = m*x+b;
yaux = yene(1);
xaux = xene(1);
b = yaux-(m*xaux);

y = (m*x) + b;
