%--------------------------------------------------------------------------
%------- Gungeon ----------------------------------------------
%------- Coceptos básicos de PDI-------------------------------------------
%------- Por: David Fernández    david.fernandez@udea.edu.co --------------
%-------      Profesor Facultad de Ingenieria BLQ 21-409  -----------------
%-------      CC 71629489, Tel 2198528,  Wpp 3007106588 -------------------
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%------- V2 Abril de 2015--------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Inicializo el sistema -----------------------------------------------
%--------------------------------------------------------------------------

clear all   % Inicializa todas las variables
close all   % Cierra todas las ventanas, archivos y procesos abiertos
clc         % Limpia la ventana de comandos
cam = imaq.VideoDevice('winvideo', 1);      %Obtiene el controlador del dispositivo de video a usar
vidInfo = imaqhwinfo(cam);                  %Se adquiere informaciï¿½n del video
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ...        %Retorna el video player para reproducir los frames en video
                                'Position', [640 1 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);  %Asigna valores a propiedades del reproductor

[howl, howlColorMap, howlAlpha] = imread('assets/down right/1.png');    %Lee la imagen del personaje
howl = imresize(howl, 0.5); howlAlpha = imresize(howlAlpha, 0.5);       %Redimensiona el personaje
fondo = imread('assets/fondo2.png'); fondo = imresize(fondo, 1.5);      %Lee la imagen del fondo
[enemy, enemyColorMap, enemyAlpha] = imread('assets/enemy/1.png');      %Lee la imagen del enemigo
[enemy3, enemy3CM, enemy3Alpha] = imread('assets/enemy/3.png');         %Lee la imagen del enemigo3
[enemyCast1, enemyCast1CM, enemyCast1Alpha] = imread('assets/enemy/cast1.png');     %Lee la primera imagen del enemigo casteando
[enemyCast2, enemyCast2CM, enemyCast2Alpha] = imread('assets/enemy/cast2.png');     %Lee la segunda imagen del enemigo casteando
[enemyCast3, enemyCast3CM, enemyCast3Alpha] = imread('assets/enemy/cast3.png');     %Lee la tercera imagen del enemigo casteando
[enemyCast4, enemyCast4CM, enemyCast4Alpha] = imread('assets/enemy/cast4.png');     %Lee la cuarta imagen del enemigo casteando

%Declara variables globales  usar en el script y diferentes funciones
global bulletsImshow16 enemyCastImshow enemyIdleImshow filenemy colenemy filfondo colfondo position2Follow bulletsImshow5;
[filfondo colfondo capfondo] = size(fondo);     %Obtiene las filas, columnas y capas de la imagen del fondo
[filhowl colhowl caphowl] = size(howl);         %Obtiene las filas, columnas y capas de la imagen del personaje
[filenemy colenemy capenemy] = size(enemy);     %Obtiene las filas, columnas y capas de la imagen del enemigo

f1 = figure(1); imshow(fondo, 'Border','tight'); impixelinfo; hold on
howlImshow = imshow(howl);              %Obtiene el handler del imshow del personaje
enemyIdleImshow{1} = imshow(enemy);     %Obtiene el handler del imshow del enemigo
enemyIdleImshow{2} = imshow(enemy3);    %Obtiene el handler del imshow del enemigo3
set(enemyIdleImshow{1}, 'AlphaData', enemyAlpha);
set(enemyIdleImshow{2}, 'AlphaData', enemy3Alpha);

enemyCastImshow{1} = imshow(enemyCast1);    %Obtiene el handler del imshow del primer enemigo casteando
enemyCastImshow{2} = imshow(enemyCast2);    %Obtiene el handler del imshow del segundo enemigo casteando
enemyCastImshow{3} = imshow(enemyCast3);    %Obtiene el handler del imshow del tercer enemigo casteando
enemyCastImshow{4} = imshow(enemyCast4);    %Obtiene el handler del imshow del cuarto enemigo casteando

bulletsImshow16 = loadBullets('assets/enemy/bullets/bullet0', 3,16); %genera un arreglo de 16 balas con 3 imÃ¡genes cada una para la animaciÃ³n.
bulletsImshow5 = loadBullets('assets/enemy/bullets/type4/', 3,5); %genera un arreglo de 5 balas con 3 imÃ¡genes cada una para la animaciÃ³n.
hold off

%se inicializan las 3 variables para ser usadas luego
enemyEspecial = 0;
positionsBullets = 0;
position2Follow = [10000, 10000];

set(f1,'Units', 'normalized','MenuBar', 'none', 'Outerposition', [0, 0, 0.5, 1], 'color', 'black'); %establece las propiedades de la ventana de juego
set(howlImshow, 'AlphaData', howlAlpha); %asigna el canal alpha al personaje para poner transparencia al fondo de su imÃ¡gen.

%Pone las 4 imagenes del enemigo fuera del area visible de la pantalla.
set(enemyCastImshow{1},'AlphaData', enemyCast1Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{2},'AlphaData', enemyCast2Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{3},'AlphaData', enemyCast3Alpha, 'XData', [1000], 'YData', [1000]);
set(enemyCastImshow{4},'AlphaData', enemyCast4Alpha, 'XData', [1000], 'YData', [1000]);

step(cam);              %Inicializa la cï¿½mara para usarse
shot = step(cam);       %Toma un frame de video

masc1 = shot*0;         %mï¿½scara superior, del tamaï¿½o del frame pero en color negro
masc2 = shot*0;         %mï¿½scara derecha, del tamaï¿½o del frame pero en color negro
masc3 = shot*0;         %mï¿½scara inferior, del tamaï¿½o del frame pero en color negro
masc4 = shot*0;         %mï¿½scara izquierda, del tamaï¿½o del frame pero en color negro
[fil,col,cap] = size(shot);     %Obtiene las filas, columnas y capas del frame
masc1(1:fil*1/3,col*1/3:col*2/3,:) = 150;   %Crea la mï¿½scara superior, asignï¿½ndole color correspondiente a 150, diferenciï¿½ndolo del negro de la imagen
masc2(fil*2/9:fil*7/9,col*3/4:col,:) = 150; %Crea la mï¿½scara superior, asignï¿½ndole color correspondiente a 150, diferenciï¿½ndolo del negro de la imagen
masc3(fil*2/3:fil,col*1/3:col*2/3,:) = 150; %Crea la mï¿½scara superior, asignï¿½ndole color correspondiente a 150, diferenciï¿½ndolo del negro de la imagen
masc4(fil*2/9:fil*7/9,1:col*1/4,:) = 150;   %Crea la mï¿½scara superior, asignï¿½ndole color correspondiente a 150, diferenciï¿½ndolo del negro de la imagen

ind = find(masc1==0 & masc2==0 & masc3==0 & masc4==0); %encuentra los ï¿½ndices donde la matriz es cero, en este caso, todo negro menos las mï¿½scaras
ind1 = find(masc1~=0);          %Encuentra los ï¿½ndices de la mï¿½scara superior
ind2 = find(masc2~=0);          %Encuentra los ï¿½ndices de la mï¿½scara derecha
ind3 = find(masc3~=0);          %Encuentra los ï¿½ndices de la mï¿½scara inferior
ind4 = find(masc4~=0);          %Encuentra los ï¿½ndices de la mï¿½scara izquierda

%Se crean auxiliares para las mï¿½scaras
aux1 = masc1;
aux2 = masc2;
aux3 = masc3;
aux4 = masc4;

fondo = imresize(fondo, [fil,col]);         %Redimensiona el fondo al tamaï¿½o del frame

for i=1:1000        %Crea un ciclo de 1000 iteraciones. Este valor puede varias, ya que no se asignï¿½ tiempo al juego
     snap = step(cam);          %Toma un nuevo frame de video
     snap = flip(snap,2);       %Invierte el frame
     snap = uint8(snap*255);    %Da formato uint8 al frame

     positionsBullets = attack1(i, positionsBullets, howlImshow); %envia los datos para mover las balas en la pantalla.

     %Asigna la porciï¿½n de frame correspondiente a la respectiva mï¿½scara
     aux1(ind1) = snap(ind1);
     aux2(ind2) = snap(ind2);
     aux3(ind3) = snap(ind3);
     aux4(ind4) = snap(ind4);

     %Llama a la funciï¿½n para sabes quï¿½ mï¿½scara detecta el color azul, el
     %retorno se asigna a la variables blue
     blue1 = containsBlue(aux1);
     blue2 = containsBlue(aux2);
     blue3 = containsBlue(aux3);
     blue4 = containsBlue(aux4);

     ifCollisionBullet = collision(howlImshow, bulletsImshow16);    %Llama a la funciï¿½n para deterctar si el personaje colisiona con las balas

     if(ifCollisionBullet == 1)         %Analiza el valor de retorno de la colisiï¿½n
        f = msgbox('has perdido!');     %Muestra una ventana con el mensaje de derrota
        break;                          %Termina el ciclo al perder el juego
     else
         %Analiza quï¿½ mï¿½scaras detectaron el color y mueve el personaje en la respectiva direcciï¿½n
         if(blue1 == 1)
            howlImshow = moveCharacter(howlImshow, 1);
         end
         if(blue2 == 1)
             howlImshow = moveCharacter(howlImshow, 2);
         end
         if(blue3 == 1)
             howlImshow = moveCharacter(howlImshow, 3);
         end
         if(blue4 == 1)
             howlImshow = moveCharacter(howlImshow, 4);
         end
         pause(0.01);
     end
     snap(ind) = fondo(ind);        %Asigna las porciones de frame correspondientes a las mï¿½scarasa la imagen de fondo
     step(hVideoIn,snap);           %Abre el player para reproducir video a partir de los frames
end
release(cam);                       %Libera el controlador de la cï¿½mara
