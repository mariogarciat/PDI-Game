function [ y ] = straightLine( x1, y1, x2, y2, newX )
%UNTITLED2  genera la linea recta a partir de dos puntos (x1,y1) y (x2,y2).

m = (y1(1)-y2(1))/(x1(1)-x2(1));        %Ecuación de la pendiente m dado los puntos

yaux = y2(1);               %Genere un y auxiliar que toma el valor del punto y2
xaux = x2(1);               %Genere un x auxiliar que toma el valor del punto x2
b = yaux-(m*xaux);          %Halla el punto de intercepción en la ordenada

y = (m*newX) + b;           %Halla el nuevo punto y de la línea, dado el nuevo punto xnew
end
