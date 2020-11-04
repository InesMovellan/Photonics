
% Programa que simula la acción de un filtro paso alto y de un filtro paso
% bajo dentro de un sistema 4f

% Autor: Inés Sánchez de Movellán Sáiz

clc
clear all
close all

% Se lee la imagen a procesar
I = imread('I0.jpg');
% Esta imagen se puede cambiar por otra, en la carpeta se incluyen también
% otras, que son: I1, I2, I3, I4, I5. Estas tienen el mismo tamaño, por lo
% que no es necesario ajustar nada. Si el tamaño fuera distinto sería
% necesario cambiar N

% La siguiente instrucción devuelve el tamaño de la matriz I
SizeI = size(I)

% Se convierte la matriz imagen I a una matriz bidimensional de N*N
% elementos. Cada elemento de la matriz representa un pixel de la imagen
I1 = rgb2gray(I);
SizeI1 = size(I1)

% La matriz I1 es el campo en el plano objeto
% Calculamos el campo en el plano focal de la primera lente del sistema
I12 = fft2(I1);
I2 = fftshift(I12);

% Definimos el filtro paso alto colocado entre las dos lentes. Este filtro
% se define como una matriz en la cual todos los elementos tienen valor 1
% menos los pertenecientes a un obstáculo circular en el centro de la 
% imagen, que tienen valor 0. De esta forma, el filtro elimina las 
% frecuencias bajas del campo incidente
N=640; % Tamaño de la matriz 640*640 (el mismo que la imagen)
M1=ones(N); % Matriz de unos
A1=1:N;
x1=A1-N/2;
y1=N/2-A1;
[x1,y1]=meshgrid(x1,y1);
R1=40; % Radio del obstáculo circular
a1=(x1.^2+y1.^2<=R1.^2); % Se define el área del obstáculo
M1(a1)=0; % Se asigna valor cero a todos los elementos pertenecientes al área 
          % definida
        
% Se calcula el campo en el plano imagen, que viene dado por la
% la transformada de Fourier del producto del filtro pas bajo por el  
% campo en el plano focal de la primera lente
I3a=fft2(M1.*I2);


% Ahora se simulará un filtro paso bajo, utilizando la misma imagen, para 
% comprobar la diferencia entre uno y otro.

% El campo en el plano focal de la primera lente es el mismo, I2, por lo 
% que no hace falta volver a calcularlo

% Para este filtro, definimos una matriz de ceros, que simulará la pantalla 
% oscura y le daremos valor 1 únicamente a los puntos que se encuentren 
% dentro de un radio determinado, de esta forma pasarán solo las frecuencias 
% bajas
M2=zeros(N); % Matriz de ceros
A2=1:N;
x2=A2-N/2;
y2=N/2-A2;
[x2,y2]=meshgrid(x2,y2);
R2=40; 
a2=(x2.^2+y2.^2<=R2.^2); % Se define el área de la abertura
M2(a2)=1; % Se asigna valor cero a todos los elementos pertenecientes al  
          % área definida
          
% Se calcula el campo en el plano imagen, que viene dado por la
% la transformada de Fourier del producto del filtro paso bajo por el  
% campo en el plano focal de la primera lente
I3b=fft2(M2.*I2);

% Representación del objeto, de los dos filtros estudiados, y de la imagen
% dada por cada uno de estos filtros

% Se puede comprobar que en el caso del filtro paso alto solo se aprecian
% los contornos de la imagen, que corresponden con las frecuencias altas,
% mientras que en el filtro paso alto, los contornos y los detalles
% aparecen borrosos, pues solo se recogen las frecuencias bajas de la
% imagen
figure
subplot(2,3,1)
imagesc(I1)
title('\bf Objeto')

subplot(2,3,2)
imagesc(M1)
title('\bf Filtro paso alto')

subplot(2,3,3)
imagesc(imrotate(abs(I3a),180))
% Es necesario rotar la imagen 180º pues sino aparece invertida tras
% aplicarle las dos transformadas de Fourier
title('\bf Imagen')

subplot(2,3,4)
imagesc(I1)
title('\bf Objeto')

subplot(2,3,5)
imagesc(M2)
title('\bf Filtro paso bajo')

subplot(2,3,6)
imagesc(imrotate(abs(I3b),180))
title('\bf Imagen')

truesize
colormap gray