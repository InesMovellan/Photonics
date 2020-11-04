function Espejo = PupilaCircular()

% Función que define una pupila ciruclar de un resonador plano paralelo o 
% confocal (esto se define fijando la curvatura)

% Autor: Inés Sánchez de Movellán Sáiz

% Se define la curvatura de los espejos (sección 2.2.1)
    curvatura=0.013;
    % Tomando curvatura 0 se define un espejo plano (sección 2.1.1)

% Se define la pupila 
    N=600; % Tamaño de la matriz 
    Pupila=zeros(N); % Matriz de ceros
    j=1:N;
    x=j-N/2;
    y=N/2-j;
    [x,y]=meshgrid(x,y);
    R=50; % Radio de la pupila circular en unidades de arbitrarias de longitud
    a=(x.^2+y.^2<=R.^2); % Se define el área de la pupila
    Pupila(a)=1; % Se asigna valor uno a todos los elementos pertenecientes al área 
                 % definida
    U1=Pupila.*exp(i*curvatura*(x.^2+y.^2)); % U1 es el campo en el espejo 1  
    Espejo=U1; % Definimos la variable Espejo, que representa los espejos 1 y 2 
               % del resonador
end