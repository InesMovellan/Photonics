clc
clear all
close all

% Simulación de la función de autocorrelación para una señal I(t) 

%%%%%%%%%%%%%%%%%%%%%%%%% ANALÍTICAMENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se definen los parámetros M (amplitud de la señal), T (periodo/100), 
% w (frecuencia angular) y k.
M = 1;
M1 = 0.5;
M2 = 0.1;
T = 0.001;
k = linspace (1,100,100);
w = 20*pi;
tau = k*T;
% Función de autocorrelación analítica, obtenida mediante integración 
g1 = 1+(M*M/2)*cos(w*tau);
g2 = 1+(M1*M1/2)*cos(w*tau);
g3 = 1+(M2*M2/2)*cos(w*tau);
figure(1)
plot (tau,g1,tau,g2,tau,g3)
legend('g(M=1)','g(M=0.5)','g(M=0.1)')
title('Función de autocorrelación (analítica)')
xlabel('tau')
ylabel('g')

%%%%%%%%%%%%%%%%%%%%%%%%% NUMÉRICAMENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para el cálculo numérico se ha definido una función intensidad, que es
% la señal I(t) con la cual se calcularán los valores medio del número de
% fotones n = I*T

% Se define el array de tiempo, con 10^4 muestras 
t = linspace(0,10,10000);
% Este array será el n(t) obtenido mediante un simulador de Poisson
n = zeros(1,length(t));

% Con el siguiente bucle for se calcula el valor medio del número de
% fotones n a partir de la señal definida como función I(t)
for i=1:length(t)
    meanN = I(t(i))*T;
    n(i) = meanN;
end
% La matriz n se llena con elementos generados mediante una estadística
% poissoniana, cuya semilla es el valor medio meanN obtenido a partir 
% de la señal I(t)
n = poissrnd(n);
% Los siguientes bucles for permiten calcular la función de autocorrelación
% g a partir de los n(t) determinados anteriormente
for j=1:length(k)
    prod =zeros(1,length(t)-j);
    for i=j+1:length(t)   
        prod(i-j) = n(i-j)*n(i);
    end
    meanProd = sum(prod)/length(prod);
    meanPn = sum(n)/length(n);
    g(j) = meanProd/(meanPn).^2;
end

% Mismo algoritmo para calcular la función de autocorrelación con M=0.5 y 
% M=0.1
n1 = zeros(1,length(t));
for i=1:length(t)
    meanN1 = I1(t(i))*T;
    n1(i) = meanN1;
end
n1 = poissrnd(n1);
for j=1:length(k)
    prod1 =zeros(1,length(t)-j);
    for i=j+1:length(t)   
        prod1(i-j) = n1(i-j)*n1(i);
    end
    meanProd1 = sum(prod1)/length(prod1);
    meanPn1 = sum(n1)/length(n1);
    g1(j) = meanProd1/(meanPn1).^2;
end

n2 = zeros(1,length(t));
for i=1:length(t)
    meanN2 = I2(t(i))*T;
    n2(i) = meanN2;
end
n2 = poissrnd(n2);
for j=1:length(k)
    prod2 =zeros(1,length(t)-j);
    for i=j+1:length(t)   
        prod2(i-j) = n2(i-j)*n2(i);
    end
    meanProd2 = sum(prod2)/length(prod2);
    meanPn2 = sum(n2)/length(n2);
    g2(j) = meanProd2/(meanPn2).^2;
end

% Se representa la función de autocorrelación obtenida numéricamente
figure(2)
plot(tau,g,tau,g1,tau,g2)
axis([0 0.1 0.5 1.5])
legend('g(M=1)','g(M=0.5)','g(M=0.1)')
title('Función de autocorrelación (numérica)')
xlabel('tau')
ylabel('g')

% Se representa la señal
figure(3)
plot(tau,I(tau),tau,I1(tau),tau,I2(tau))
legend('I(M=1)','I(M=0.5)','I(M=0.1)')
title('Señal')
xlabel('tau')
ylabel('I')


    