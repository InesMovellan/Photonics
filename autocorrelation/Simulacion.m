clc
clear all
close all

% Simulaci�n de la funci�n de autocorrelaci�n para una se�al I(t) 

%%%%%%%%%%%%%%%%%%%%%%%%% ANAL�TICAMENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se definen los par�metros M (amplitud de la se�al), T (periodo/100), 
% w (frecuencia angular) y k.
M = 1;
M1 = 0.5;
M2 = 0.1;
T = 0.001;
k = linspace (1,100,100);
w = 20*pi;
tau = k*T;
% Funci�n de autocorrelaci�n anal�tica, obtenida mediante integraci�n 
g1 = 1+(M*M/2)*cos(w*tau);
g2 = 1+(M1*M1/2)*cos(w*tau);
g3 = 1+(M2*M2/2)*cos(w*tau);
figure(1)
plot (tau,g1,tau,g2,tau,g3)
legend('g(M=1)','g(M=0.5)','g(M=0.1)')
title('Funci�n de autocorrelaci�n (anal�tica)')
xlabel('tau')
ylabel('g')

%%%%%%%%%%%%%%%%%%%%%%%%% NUM�RICAMENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para el c�lculo num�rico se ha definido una funci�n intensidad, que es
% la se�al I(t) con la cual se calcular�n los valores medio del n�mero de
% fotones n = I*T

% Se define el array de tiempo, con 10^4 muestras 
t = linspace(0,10,10000);
% Este array ser� el n(t) obtenido mediante un simulador de Poisson
n = zeros(1,length(t));

% Con el siguiente bucle for se calcula el valor medio del n�mero de
% fotones n a partir de la se�al definida como funci�n I(t)
for i=1:length(t)
    meanN = I(t(i))*T;
    n(i) = meanN;
end
% La matriz n se llena con elementos generados mediante una estad�stica
% poissoniana, cuya semilla es el valor medio meanN obtenido a partir 
% de la se�al I(t)
n = poissrnd(n);
% Los siguientes bucles for permiten calcular la funci�n de autocorrelaci�n
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

% Mismo algoritmo para calcular la funci�n de autocorrelaci�n con M=0.5 y 
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

% Se representa la funci�n de autocorrelaci�n obtenida num�ricamente
figure(2)
plot(tau,g,tau,g1,tau,g2)
axis([0 0.1 0.5 1.5])
legend('g(M=1)','g(M=0.5)','g(M=0.1)')
title('Funci�n de autocorrelaci�n (num�rica)')
xlabel('tau')
ylabel('g')

% Se representa la se�al
figure(3)
plot(tau,I(tau),tau,I1(tau),tau,I2(tau))
legend('I(M=1)','I(M=0.5)','I(M=0.1)')
title('Se�al')
xlabel('tau')
ylabel('I')


    