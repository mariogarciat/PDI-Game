function [ y ] = straightLine( x1, y1, x2, y2, newX )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

m = (y1(1)-y2(1))/(x1(1)-x2(1));

yaux = y2(1);
xaux = x2(1);
b = yaux-(m*xaux);

y = (m*newX) + b;
end

