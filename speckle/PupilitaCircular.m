function Pup = PupilitaCircular()

% Funci�n que define una pupila ciruclar con tip y tilt aleatorio

% Autor: In�s S�nchez de Movell�n S�iz

% Se define el tip y el tilt como una distribuci�n normal de numeros
% aleatorios entre 0 y 2*pi
    tip = 2*pi*randn(1);
    tilt = 2*pi*randn(1);
 
% Se define la pupila
    N=32; % Tama�o de la matriz 
    pad = 2;
    P=zeros(N); % Matriz de ceros
    j=1:N;
    x=j-N/2;
    y=N/2-j;
    [x,y]=meshgrid(x,y);
    R=N/pad; % Radio de la pupila en unidades de arbitrarias de longitud
    a=(x.^2+y.^2<=R.^2); % �rea de la pupila
    P(a)=1; % Se asigna valor uno a todos los elementos pertenecientes al �rea 
            % definida
    Pup = P.*exp(i*(tip*x+tilt*y)); % Se obtiene una orientaci�n aleatoria
                                    % de la pupila
end