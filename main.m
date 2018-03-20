clear all, close all, clc
cam = videoinput('winvideo');
triggerconfig(cam,'manual');
set(cam,'TimerPeriod',0.3);
howl = imread('assets/howlup.jpg');
fondo = imread('fondo.jpg'); 
fondo2 = fondo;
enemy = imread('wea.png');

[filfondo colfondo capfondo] = size(fondo);
[filhowl colhowl caphowl] = size(howl);
[filenemy colenemy capenemy] = size(enemy);

colshift = 50;
rowshift = 30;
fondo((1:size(howl,1))+rowshift, (1:size(howl,2))+colshift, :) = howl;
fondo((1:size(enemy,1))+(filfondo/2-filenemy/2), (1:size(enemy,2))+(colfondo/2-colenemy/2), :) = enemy;
fondo2((1:size(enemy,1))+(filfondo/2-filenemy/2), (1:size(enemy,2))+(colfondo/2-colenemy/2), :) = enemy;



% indhowl = size(howl);
% fondo(indhowl) = howl(indhowl);
imshow(fondo);
scene = fondo2;
for i=1:10
%     colshift = colshift + 100;
%     rowshift = rowshift + 100;
%     fondo = fondo2;
%     fondo((1:size(howl,1))+rowshift, (1:size(howl,2))+colshift, :) = howl;
%     
    scene = moveDown(scene,howl,rowshift);
    imshow(scene);
    disp(i)
end
    

start(cam);


shot = getsnapshot(cam);
masc1 = shot*0;
masc2 = shot*0;
masc3 = shot*0;
masc4 = shot*0;
[fil,col,cap] = size(shot);     
masc1(1:fil*1/3,col*1/3:col*2/3,:) = 150;
masc2(fil*2/9:fil*7/9,col*3/4:col,:) = 150;
masc3(fil*2/3:fil,col*1/3:col*2/3,:) = 150;
masc4(fil*2/9:fil*7/9,1:col*1/4,:) = 150;

ind = find(masc1==0 & masc2==0 & masc3==0 & masc4==0); %encuentra los �ndices donde la matriz es cero, en este caso, todo negro menos las m�scaras
ind1 = find(masc1~=0);
ind2 = find(masc2~=0);
ind3 = find(masc3~=0);
ind4 = find(masc4~=0);

aux1 = masc1;
aux2 = masc2;
aux3 = masc3;
aux4 = masc4;

fondo = imresize(fondo, [fil,col]);
%figure(2); 
for i=1:100
     snap = peekdata(cam, 1);
     snap = flip(snap,2);
     
     aux1(ind1) = snap(ind1);
     aux2(ind2) = snap(ind2);
     aux3(ind3) = snap(ind3);
     aux4(ind4) = snap(ind4);
     %imshow(aux);
     blue1 = containsBlue(aux1);
     blue2 = containsBlue(aux2);
     blue3 = containsBlue(aux3);
     blue4 = containsBlue(aux4);
     
     if(blue1 == 1)
         disp('arriba');
     end
     if(blue2 == 1)
         disp('derecha');
     end     
     if(blue3 == 1)
         [scene, rowshift] = moveDown(fondo2, howl, rowshift);
         imshow(scene);
         disp('abajo');
     end
     if(blue4 == 1)
         disp('izquierda');
     end     
     
     
%      snap(ind) = fondo(ind);
%      imshow(snap);impixelinfo
     
         
     
     %disp(blue1);
     %subplot 121; imshow(snap); subplot 122; imshow(fondo); impixelinfo;
end
imshow(scene);
stop(cam);
% bluesnap = snap(:,:,3);
% redsnap = snap(:,:,1);
% greensnap = snap(:,:,2);
% figure(3);imshow([redsnap;greensnap;bluesnap]); impixelinfo;

% 
% while 1
%     imageData = peekdata(cam, 1);
%     imshow(imageData);
% end






%figure(3);imshow(csnap);
