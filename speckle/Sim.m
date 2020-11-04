clc
clear all
close all

% Simulación de la correción al patrón de speckle producido por la 
% atmósfera cuando se observan objetos estelares distantes a través de
% un telescopio

% Autor: Inés Sánchez de Movellán Sáiz


% Se define una matriz de ceros
tic
N = 512;
pad =8; 
Pupilitas=zeros(N);

ld =32; % Tamaño de las pupilitas

z=zeros(N); % Se inicializa la matriz grande
rate = N/ld; % Número de pupilitas que entran en vertical
numH = (N-ld) / (3*ld/2); % Número de pupilitas que entran en horizontal
par = merge(z, ld, rate, numH, 0); % Columnas pares
impar = merge(z, ld, rate, numH, 1); % Columnas impares

% Se suman las matrices de columnas pares e impares para cubrir todo el espacio
Pupilitas = par+impar;

% Se define la pupila del telescopio 
PupTelescopio=zeros(N);
curvatura=0.01;
j=1:N;
x=j-N/2;
y=N/2-j;
[x,y]=meshgrid(x,y);
R=N/pad; % Radio de la pupila en unidades de arbitrarias de longitud
a=(x.^2+y.^2<=R.^2); % Se define la superficie de la pupila del telescopio
PupTelescopio(a)=1;
PupTelescopio = PupTelescopio.*exp(1i*curvatura*(x.^2+y.^2));

% Se crea un frente de ondas con fase aleatoria, simulando el efecto que
% produce la atmósfera


% Se multiplica la matriz de pupilitas por la pupila del telescopio
% Este producto simula el objeto que se observa con el telescopio a través
% de la atmósfera terrestre
Pupila = Pupilitas.*PupTelescopio;
% La transformada de Fourier nos da la imagen del objeto a travéz del 
% telescopio
I = fftshift(fft2(frente.*Pupila));
Vmax=max(I);
IMax=max(Vmax);
Img = abs(real(I./IMax));

% Se calcula la variación media de intensidad en cada pixel, y se hace 
% la media de todos los píxeles
meanIpix = 0;
varImax = 0;
for i=21:492
    for k=21:492
        varI1=Img(i,k)-Img(i+20,k);
        varI2=Img(i,k)-Img(i-20,k);
        varI3=Img(i,k)-Img(i,k+20);
        varI4=Img(i,k)-Img(i,k-20);
        varImed = abs((varI1+varI2+varI3+varI4)/4);
        meanIpix= meanIpix + varImed;
    end 
end

meanVarIRel = (meanIpix / (502-11)^2)

% Representación gráfica
% Se representa el objeto y la imagen que viene dada por la transformada de
% Fourier en 2 y 3 dimesiones
figure(1)
subplot(1,2,1)
imagesc(abs(real(Pupila)))
subplot(1,2,2)
imagesc(Img)
truesize

figure(2)
mesh(Img)
axis ([0 512 0 512 0 1])


