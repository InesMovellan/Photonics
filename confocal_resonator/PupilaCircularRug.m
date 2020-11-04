function Espejo = PupilaCircularRug()

% Funci�n que define una pupila circular y espejos de superficie rugosa
% secci�n 2.2.2

% Autor: In�s S�nchez de Movell�n S�iz

% Se define la curvatura de los espejos
    curvatura=0.013;
    % Tomando curvatura 0.0 se define un espejo plano 

% Se define la pupila 
    N=600; % Tama�o de la matriz 
    Pupila=rand(N); % Matriz de n�meros aleatorios que simula la rugosidad en la superficie
    j=1:N;
    x=j-N/2;
    y=N/2-j;
    [x,y]=meshgrid(x,y);
    R=50; % Radio de la pupila circular en unidades de arbitrarias de longitud
    a=(x.^2+y.^2>=R.^2); % Se define el �rea externo a la pupila
    Pupila(a)=0; % Se asigna valor cero a todos los elementos que se  
                 % encuentren fuera de la pupila
    U1=Pupila.*exp(i*curvatura*(x.^2+y.^2)); % U1 es el campo en el espejo 1  
    Espejo=U1;
end