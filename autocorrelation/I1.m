function Intensidad = I1(t)
    % Se definen los par�metros de la se�al
    I0 = 10000; % fotones / s
    M = 0.5; % Amplitud
    w = 20*pi; % Frecuencia en rad/s
    % Se define la se�al
    Intensidad = I0*(1+M*cos(w*t));
end