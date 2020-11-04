clc
clear all
close all

% Simulaci�n de un resonador 

% Dependiendo de la funci�n empleada se simula
%       - Resonador plano paralelo/confocal con pupila circular [PupilaCircular()]
%       - Resonador plano paralelo con pupila rectangular [PupilaRectangular()]
%       - Resonador confocal con espejos de superficies rugosas [PupilaCircularRug()]

% Autor: In�s S�nchez de Movell�n S�iz

% Se definen los espejos con una de las tres funciones posibles
%       - PupilaCircular()
%       - PupilaRectangular()
%       - PupilaCircularRug()
    Espejo=PupilaCircularRug();
    U1=Espejo; % Se define el campo en el primer espejo (espejo 1)

% Primera iteraci�n. Se realiza fuera del bucle pues el desplazamiento de
% la transformada de Fourier solo se aplica una vez.
    U2=fft2(U1); % U2 es el campo en el espejo 2
    U2 = fftshift(U2); % Se desplaza la transformada de Fourier para que 
                       % aparezca centrada
    U3 = U2.*Espejo; % Se multiplica el campo U2 por el espejo 2 (rebote 
                     % en el espejo 2)
    U4=fft2(U3); % U4 es el campo en el espejo 1
    U1=U4.*Espejo; % Se multiplica U4 por el espejo 1 (rebote en el espejo 1)
 
    
% Bucle que realiza el resto de iteraciones. Cada iteraci�n representa dos
% reflexiones
    for i=1:5
        U2=fft2(U1);
        U3 = Espejo.*U2;
        U4=fft2(U3);
        U1=U4.*Espejo;
    end
    

% Representaci�n gr�fica en 2D y en 3D del campo en el espejo 1 y en el 
% espejo 2. Tambi�n se representa la pupila.

% Representaci�n en 2D. Proyecci�n del campo en el plano XY
    figure(1)
    
    subplot(1,3,1);         
    imagesc(abs(Espejo));
    title('\bf Pupila');

    subplot(1,3,2);
    imagesc(abs(U4));
    title('\bf Campo en el espejo 1');

    subplot(1,3,3);
    imagesc(abs(U2));
    title('\bf Campo en el espejo 2');
    
    truesize % Ajuste de los ejes
    colormap hot % Ajuste del color
    
% Representaci�n en 3D
    figure(2)
    mesh(abs(U4));
    title('\bf Campo en el espejo 1')

    figure(3)
    mesh(abs(U2));
    title('\bf Campo en el espejo 2')