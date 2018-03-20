%--------------------------------------------------------------------------
%------- PROCESAMIENTO DIGITAL DE IM�GENES --------------------------------
%------- Coceptos b�sicos de PDI-------------------------------------------
%------- Por: Juli�n V�squez Giraldo    julian.vasquezg@udea.edu.co -------
%-------      CC 1035436986   ---------------------------------------------
%-------      Yaqueline Hoyos Montes    yaqueline.hoyos@udea.edu.co -------
%-------      CC 1038407865   ---------------------------------------------
%------- 25 de septiembre de 2017 -----------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Inicializo el sistema -----------------------------------------------
%--------------------------------------------------------------------------

function [] = DrawMe(redThresh)
if nargin < 1
    redThresh = 0.1;  % Umbral de detecci�n de rojo
end

%--------------------------------------------------------------------------
%--2. Entorno gr�fico -----------------------------------------------------
%--------------------------------------------------------------------------

sectores=[0,0,0,0,0]; % Vector de apoyo para las franjas grises del entorno gr�fico
fondo = imread('fondo.jpg'); % Se carga la imagen del juego
fondo = rgb2gray(fondo); % Pasamos la imagen a escala de grises
limSuperior=21; % L�mite superior de la im�gen de fondo en pixeles
limInferior=31; % L�mite inferior de la im�gen de fondo en pixeles
ancho = 65; % Ancho de la imagen de fondo en pixeles
linea1=9; % Lugar donde se pintar� la primera franja gris del entorno gr�fico
linea2=21; % Lugar donde se pintar� la segunda franja gris del entorno gr�fico
linea3=32; % Lugar donde se pintar� la tercera franja gris del entorno gr�fico
linea4=43; % Lugar donde se pintar� la cuarta franja gris del entorno gr�fico
linea5=52; % Lugar donde se pintar� la quinta franja gris del entorno gr�fico
for i=limSuperior:limInferior % Se le asigna color a las franjas
    fondo(i,linea1)=220; % Se le asigna el color 220 a la primera franja
    fondo(i,linea1+1)=220; % La franja se pinta con 2 pixeles de ancho
    fondo(i,linea2)=200; % Se le asigna el color 200 a la segunda franja
    fondo(i,linea2+1)=200; % La franja se pinta con 2 pixeles de ancho
    fondo(i,linea3)=180; % Se le asigna el color 180 a la tercera franja
    fondo(i,linea3+1)=180; % La franja se pinta con 2 pixeles de ancho
    fondo(i,linea4)=160; % Se le asigna el color 160 a la cuarta franja
    fondo(i,linea4+1)=160; % La franja se pinta con 2 pixeles de ancho
    fondo(i,linea5)=140; % Se le asigna el color 140 a la quinta franja
    fondo(i,linea5+1)=140; % Segundo pixel de ancho
    fondo(i,linea5+2)=140; % La franja "meta" se pinta con 3 pixeles de ancho
end

%--------------------------------------------------------------------------
%--2. Especificaciones de la ventana de juego -----------------------------
%--------------------------------------------------------------------------

drawStruct.figh = figure('Units','pixels',...  % La figura que aparecer� en la ventana ser� dada por pixeles
              'Position',[10 50 600 650],... % La figura tiene un tama�o de 600 por 650
              'Menubar','none',... % No vamos a tener men� en la ventana
              'Name','DrawMe',... % Se le asigna un nombre a la ventana de juego
              'NumberTitle','off',... % La ventana aparecer� sin n�mero de t�tulo
              'Color', 'k',... % Ser� el color del fondo 
              'Resize','on'); % Se podr� modificar el tama�o de la aventana gr�ficamente
drawStruct.axs = axes('Units','pixels',...  % Los ejes ser�n representados tambi�n en pixeles
            'Position',[5 5 590 640],... % Posici�n de la imagen en la ventana
            'Xlim',[-6 0],... % L�mite en el eje x
            'YLim',[-4.5 0],... % L�mite en el eje y
            'Color', 'k',... % Color de los ejes negro
            'DrawMode','fast'); 
set(drawStruct.axs,'xTickLabel',[],'yTickLabel',[],'xTick',[],'yTick',[]);  % No aparecen las marcas de los ejes

%--------------------------------------------------------------------------
%--3. Especificaciones de la ventana de video -----------------------------
%--------------------------------------------------------------------------

vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ... % Formato del video
                    'ROI', [1 1 640 480], ... % Especificaciones del video
                    'ReturnedColorSpace', 'rgb');  % Video en formato rgb
vidInfo = imaqhwinfo(vidDevice);  % Se adquiere informaci�n del video
hblob = vision.BlobAnalysis('AreaOutputPort', false, ... 
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MaximumBlobArea', 3000, ... % El objeto rojo que se reconoce no debe superar un �rea de 3000 pixeles cuadrados
                                'MaximumCount', 1);  % S�lo podr� reconocer un objeto a la vez
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'Custom', ...
                                    'CustomBorderColor', [1 0 0], ... % Se agrega un borde de color rojo al objeto que se reconoce
                                    'Fill', true, ... % Se rellena la figura que reconoce el objeto
                                    'FillColor', 'Custom', ...
                                    'CustomFillColor', [1 0 0], ...
                                    'Opacity', 0.4);  % El relleno ser� un poco transparente
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ...
                                'Position', [60+vidInfo.MaxWidth 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);   % Make system object for output video stream
% hMarker = vision.MarkerInserter('Shape','Circle','Fill','true','FillColor','Black');

%--------------------------------------------------------------------------
%--2. L�gica del juego ----------------------------------------------------
%--------------------------------------------------------------------------

nFrame = 200; % L�mite del tiempo de juego en pantallazos
iterator = 0; % Variable de apoyo para la condici�n de parada del while

centX = 10; centY = 10;  % Feature Centroid initialization

while iterator<nFrame
    rgbFrame = step(vidDevice);  % Tomamos el pantallazo
    diffFrame = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame));  % Identificamos el componente en rojo
    binFrame = im2bw(diffFrame, redThresh);  % Se convierte la imagen a binario
    binFrame = bwareaopen(binFrame,1200);  % Descartamos �reas m�s peque�as a 1200 pixeles cuadrados
    [centroid, bbox] = step(hblob, binFrame);  % Get the reqired statistics of remaining blobs
    if ~isempty(bbox)  %  Get the centroid of remaining blobs
        centX = centroid(1); centY = centroid(2);
    end
    if(fondo(round(centY/10),round(centX/10))<100 && iterator > 50) % Nos aseguramos que el usuario centre 
                                                                    % el objeto rojo en la imagen del juego
        iterator=nFrame; % Se termina el juego si en menos de 50 pantallazos el usuario no pudo centrar el objeto rojo
    end
    if(iterator == 50) % Cuando se llega a 50 pantallazos, empezamos a hacer la imagen m�s peque�a
        for i = 1:ancho
            fondo(limInferior,i)=0; % Reducimos la imagen en la parte inferior
            fondo(limSuperior,i)=0; % Reducimos la imagen en la parte superior
        end
        limInferior= limInferior - 1; % Le damos un nuevo valor a la variable limInferior
        limSuperior= limSuperior + 1; % Le damos un nuevo valor a la variable limSuperior
    end
    if(iterator == 100) % Cuando se llega a 100 pantallazos, reducimos la imagen de nuevo
        for i = 1:ancho
            fondo(limInferior,i)=0; % Reducimos la imagen en la parte inferior
            fondo(limSuperior,i)=0; % Reducimos la imagen en la parte superior
        end
        limInferior= limInferior - 1; % Le damos un nuevo valor a la variable limInferior
        limSuperior= limSuperior + 1; % Le damos un nuevo valor a la variable limSuperior
    end
    if(iterator == 130) % Cuando se llega a 130 pantallazos, reducimos la imagen de nuevo
        for i = 1:ancho
            fondo(limInferior,i)=0; % Reducimos la imagen en la parte inferior
            fondo(limSuperior,i)=0; % Reducimos la imagen en la parte superior
        end
        limInferior= limInferior - 1; % Le damos un nuevo valor a la variable limInferior
        limSuperior= limSuperior + 1; % Le damos un nuevo valor a la variable limSuperior
    end
    if(iterator == 150) % Cuando se llega a 150 pantallazos, reducimos la imagen de nuevo
        for i = 1:ancho
            fondo(limInferior,i)=0; % Reducimos la imagen en la parte inferior
            fondo(limSuperior,i)=0; % Reducimos la imagen en la parte superior
        end
        limInferior= limInferior - 1; % Le damos un nuevo valor a la variable limInferior
        limSuperior= limSuperior + 1; % Le damos un nuevo valor a la variable limSuperior
    end
    if(iterator == 170) % Cuando se llega a 170 pantallazos, reducimos la imagen de nuevo
        for i = 1:ancho
            fondo(limInferior,i)=0; % Reducimos la imagen en la parte inferior
            fondo(limSuperior,i)=0; % Reducimos la imagen en la parte superior
        end
        limInferior= limInferior - 1; % Le damos un nuevo valor a la variable limInferior
        limSuperior= limSuperior + 1; % Le damos un nuevo valor a la variable limSuperior
    end
    if(iterator == 190) % Cuando se llega a 190 pantallazos, reducimos la imagen de nuevo
        for i = 1:ancho
            fondo(limInferior,i)=0; % Reducimos la imagen en la parte inferior
            fondo(limSuperior,i)=0; % Reducimos la imagen en la parte superior
        end
    end
    if(fondo(round(centY/10),round(centX/10))==220 && sectores(1)==0)
        sectores(1)=1; % Si el usuario pinta la primera franja, le damos un valor de 1 a la primera posici�n del vector
    end
    if(fondo(round(centY/10),round(centX/10))==200 && sectores(2)==0)
        sectores(2)=1; % Si el usuario pinta la segunda franja, le damos un valor de 1 a la segunda posici�n del vector
    end
    if(fondo(round(centY/10),round(centX/10))==180 && sectores(3)==0)
        sectores(3)=1; % Si el usuario pinta la tercera franja, le damos un valor de 1 a la tercera posici�n del vector
    end
    if(fondo(round(centY/10),round(centX/10))==160 && sectores(4)==0)
        sectores(4)=1; % Si el usuario pinta la cuarta franja, le damos un valor de 1 a la cuarta posici�n del vector
    end
    if(fondo(round(centY/10),round(centX/10))==140 && sectores(5)==0)
        sectores(5)=1; % Si el usuario pinta la quinta franja, le damos un valor de 1 a la quinta posici�n del vector
        iterator=nFrame; % Damos el juego por terminado cuando el usuario toca la �ltima franja
    end
    vidIn = step(hshapeinsRedBox, rgbFrame, bbox);  % Put a Red bounding box in input video stream    
    step(hVideoIn, vidIn);  % Cargamos el video nuevamente
    imshow(fondo); impixelinfo; % Cargamos la imagen de fondo nuevamente
    fondo(round(centY/10),round(centX/10))=100;
    iterator=iterator+1; % Aumentamos la variable iterator
end
puntaje=sum(sectores); % Hacemos una suma de los valores del vector para verificar si el usuario pas� por cada una de ellas
if(puntaje~=5)
    text(10,10,'GAME OVER','Color','r','FontSize',60); % Si el usuario no pasa por cada una de las franjas, pierde
else
    text(10,10,'YOU WIN','Color','g','FontSize',60); % Si el usuario pasa por cada una de las franjas, gana
end
end
