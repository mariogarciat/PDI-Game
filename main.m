clear all, close all, clc
cam = videoinput('winvideo');
triggerconfig(cam,'manual');
set(cam,'TimerPeriod',0.3);
fondo = imread('fondo.jpg'); 
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

ind = find(masc1==0 & masc2==0 & masc3==0 & masc4==0); %encuentra los índices donde la matriz es cero, en este caso, todo negro menos las máscaras
ind1 = find(masc1~=0);
ind2 = find(masc2~=0);
ind3 = find(masc3~=0);
ind4 = find(masc4~=0);

fondo = imresize(fondo, [fil,col]);
figure(2); 
for i=1:100
     snap = peekdata(cam, 1);
     snap = flip(snap,2);
     aux = masc1;
     aux(aux>0) = snap(ind1);
     blue1 = containsBlue(aux);
     
     
%      blue2 = containsBlue(snap(ind2));
%      blue3 = containsBlue(snap(ind3));
%      blue4 = containsBlue(snap(ind4));
     %snap(ind) = fondo(ind);
     
     
         
     
     disp(blue1);
     subplot 121; imshow(snap); subplot 122; imshow(fondo); impixelinfo;
%      figure(3); imshow(bwsnap);
end
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
