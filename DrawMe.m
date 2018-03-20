%--------------------------------------------------------------------------
%------- PROCESAMIENTO DIGITAL DE IMÁGENES --------------------------------
%------- Coceptos básicos de PDI-------------------------------------------
%------- Por: Julián Vásquez Giraldo    julian.vasquezg@udea.edu.co -------
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
    redThresh = 0.1;  % Umbral de detección de rojo
end

%--------------------------------------------------------------------------
%--2. Entorno gráfico -----------------------------------------------------
%--------------------------------------------------------------------------

sectores=[0,0,0,0,0]; % Vector de apoyo para las franjas grises del entorno gráfico
fondo = imread('fondo.jpg'); % Se carga la imagen del juego
fondo = rgb2gray(fondo); % Pasamos la imagen a escala de grises
limSuperior=21; % Límite superior de la imágen de fondo en pixeles
limInferior=31; % Límite inferior de la imágen de fondo en pixeles
ancho = 65; % Ancho de la imagen de fondo en pixeles
linea1=9; % Lugar donde se pintará la primera franja gris del entorno gráfico
linea2=21; % Lugar donde se pintará la segunda franja gris del entorno gráfico
linea3=32; % Lugar donde se pintará la tercera franja gris del entorno gráfico
linea4=43; % Lugar donde se pintará la cuarta franja gris del entorno gráfico
linea5=52; % Lugar donde se pintará la quinta franja gris del entorno gráfico
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

drawStruct.figh = figure('Units','pixels',...  % La figura que aparecerá en la ventana será dada por pixeles
              'Position',[10 50 600 650],... % La figura tiene un tamaño de 600 por 650
              'Menubar','none',... % No vamos a tener menú en la ventana
              'Name','DrawMe',... % Se le asigna un nombre a la ventana de juego
              'NumberTitle','off',... % La ventana aparecerá sin número de título
              'Color', 'k',... % Será el color del fondo 
              'Resize','on'); % Se podrá modificar el tamaño de la aventana gráficamente
drawStruct.axs = axes('Units','pixels',...  % Los ejes serán representados también en pixeles
            'Position',[5 5 590 640],... % Posición de la imagen en la ventana
            'Xlim',[-6 0],... % Límite en el eje x
            'YLim',[-4.5 0],... % Límite en el eje y
            'Color', 'k',... % Color de los ejes negro
            'DrawMode','fast'); 
set(drawStruct.axs,'xTickLabel',[],'yTickLabel',[],'xTick',[],'yTick',[]);  % No aparecen las marcas de los ejes

%--------------------------------------------------------------------------
%--3. Especificaciones de la ventana de video -----------------------------
%--------------------------------------------------------------------------

vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ... % Formato del video
                    'ROI', [1 1 640 480], ... % Especificaciones del video
                    'ReturnedColorSpace', 'rgb');  % Video en formato rgb
vidInfo = imaqhwinfo(vidDevice);  % Se adquiere información del video
hblob = vision.BlobAnalysis('AreaOutputPort', false, ... 
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MaximumBlobArea', 3000, ... % El objeto rojo que se reconoce no debe superar un área de 3000 pixeles cuadrados
                                'MaximumCount', 1);  % Sólo podrá reconocer un objeto a la vez
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'Custom', ...
                                    'CustomBorderColor', [1 0 0], ... % Se agrega un borde de color rojo al objeto que se reconoce
                                    'Fill', true, ... % Se rellena la figura que reconoce el objeto
                                    'FillColor', 'Custom', ...
                                    'CustomFillColor', [1 0 0], ...
                                    'Opacity', 0.4);  % El relleno será un poco transparente
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ...
                                'Position', [60+vidInfo.MaxWidth 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);   % Make system object for output video stream
% hMarker = vision.MarkerInserter('Shape','Circle','Fill','true','FillColor','Black');

%--------------------------------------------------------------------------
%--2. Lógica del juego ----------------------------------------------------
%--------------------------------------------------------------------------

nFrame = 200; % Límite del tiempo de juego en pantallazos
iterator = 0; % Variable de apoyo para la condición de parada del while

centX = 10; centY = 10;  % Feature Centroid initialization

while iterator<nFrame
    rgbFrame = step(vidDevice);  % Tomamos el pantallazo
    diffFrame = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame));  % Identificamos el componente en rojo
    binFrame = im2bw(diffFrame, redThresh);  % Se convierte la imagen a binario
    binFrame = bwareaopen(binFrame,1200);  % Descartamos áreas más pequeñas a 1200 pixeles cuadrados
    [centroid, bbox] = step(hblob, binFrame);  % Get the reqired statistics of remaining blobs
    if ~isempty(bbox)  %  Get the centroid of remaining blobs
        centX = centroid(1); centY = centroid(2);
    end
    if(fondo(round(centY/10),round(centX/10))<100 && iterator > 50) % Nos aseguramos que el usuario centre 
                                                                    % el objeto rojo en la imagen del juego
        iterator=nFrame; % Se termina el juego si en menos de 50 pantallazos el usuario no pudo centrar el objeto rojo
    end
    if(iterator == 50) % Cuando se llega a 50 pantallazos, empezamos a hacer la imagen más pequeña
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
        sectores(1)=1; % Si el usuario pinta la primera franja, le damos un valor de 1 a la primera posición del vector
    end
    if(fondo(round(centY/10),round(centX/10))==200 && sectores(2)==0)
        sectores(2)=1; % Si el usuario pinta la segunda franja, le damos un valor de 1 a la segunda posición del vector
    end
    if(fondo(round(centY/10),round(centX/10))==180 && sectores(3)==0)
        sectores(3)=1; % Si el usuario pinta la tercera franja, le damos un valor de 1 a la tercera posición del vector
    end
    if(fondo(round(centY/10),round(centX/10))==160 && sectores(4)==0)
        sectores(4)=1; % Si el usuario pinta la cuarta franja, le damos un valor de 1 a la cuarta posición del vector
    end
    if(fondo(round(centY/10),round(centX/10))==140 && sectores(5)==0)
        sectores(5)=1; % Si el usuario pinta la quinta franja, le damos un valor de 1 a la quinta posición del vector
        iterator=nFrame; % Damos el juego por terminado cuando el usuario toca la última franja
    end
    vidIn = step(hshapeinsRedBox, rgbFrame, bbox);  % Put a Red bounding box in input video stream    
    step(hVideoIn, vidIn);  % Cargamos el video nuevamente
    imshow(fondo); impixelinfo; % Cargamos la imagen de fondo nuevamente
    fondo(round(centY/10),round(centX/10))=100;
    iterator=iterator+1; % Aumentamos la variable iterator
end
puntaje=sum(sectores); % Hacemos una suma de los valores del vector para verificar si el usuario pasó por cada una de ellas
if(puntaje~=5)
    text(10,10,'GAME OVER','Color','r','FontSize',60); % Si el usuario no pasa por cada una de las franjas, pierde
else
    text(10,10,'YOU WIN','Color','g','FontSize',60); % Si el usuario pasa por cada una de las franjas, gana
end
end
