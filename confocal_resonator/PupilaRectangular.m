function Espejo = PupilaRectangular()

% Función que define una pupila rectangular de un resonador plano paralelo
% sección 2.1.2

% Autor: Inés Sánchez de Movellán Sáiz

% Se define la pupila 
    N = 600; % Tamaño de la matriz 
    c = N/2; 
    Lx =50; % Longitud de la pupila en el eje x
    Ly = 50; % Longitud de la pupila en el eje y
    Pupila=zeros(N); % Matriz que simulará la pupila, inicialmente todos los
                     % elementos de esta matriz tienen valor nulo

% Con el siguiente bucle se recorre la matriz Pupila asignando valor 1 a los 
% elementros que se encuentran en un rango dado por Lx y Ly desde el centro
% de dicha matriz. Los elementos fuera de este área tienen valor nulo.
for i=1:N
    for j=1:N
        if(length(Pupila(1:i,j))>(c-Ly/2)&& length(Pupila(1:i,j))<(c+Ly/2)&& length(Pupila(i,1:j))>(c-Lx/2)&& length(Pupila(i,1:j))<(c+Lx/2))
            Pupila(i,j)= 1;
        end
    end
end

 U1=Pupila; % U1 es el campo en el espejo 1
 Espejo=U1; % Definimos la variable Espejo, que representa los espejos 1 y 2 
            % del resonador
end