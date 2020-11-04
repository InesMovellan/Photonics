function Intensidad = I1(t)
    % Se definen los parámetros de la señal
    I0 = 10000; % fotones / s
    M = 0.5; % Amplitud
    w = 20*pi; % Frecuencia en rad/s
    % Se define la señal
    Intensidad = I0*(1+M*cos(w*t));
end