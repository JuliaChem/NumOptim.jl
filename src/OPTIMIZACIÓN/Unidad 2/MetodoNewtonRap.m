%% NEWTON RAPSON
clear;
clc;
syms x
disp('Metodo de Newton Rapson');
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES');
disp('x es la variable definida');
f=input('Ingrese la función:');
Ydx=(diff(f,x));
disp('La primera derivada es:');
pretty(Ydx) 
disp('Sus raices son:');
pretty(vpa(solve(Ydx)))
disp('Si sus raices no contiene un valor real, no tiene solución ...');
disp('pues sus raices son imaginarias ( ctrl+c )');
x0=input('Ingrese el valor inicial: ');
tolerancia=input('Ingrese el porcentaje de error: ');
i=1;
fx(i)=x0  %% xO va a ser fx(1) primero y evaluamos lo siguiente. 
Primeraderivada=diff(f) %% Primera derivada
PrimeraderivadaEvaluada=vpa(subs(Primeraderivada,x,fx(i))) % sustitución en la primera derivada
Segundaderivada=diff(Primeraderivada) %% Segunda derivada
SegundaderivadaEvaluada=vpa(subs(Segundaderivada,x,fx(i)))  % sustitucion en la segunda derivada
error(1)=100; 
while abs(error(i)) >= tolerancia
    fx(i+1)=fx(i)-PrimeraderivadaEvaluada/SegundaderivadaEvaluada; 
    PrimeraderivadaEvaluada=subs(Primeraderivada,x,fx(i+1));
    SegundaderivadaEvaluada=subs(Segundaderivada,x,fx(i+1));
    error(i+1)=abs((fx(i+1)-fx(i))/fx(i+1)*100);
    i=i+1;
end
fprintf('i      fx(i)      Error aprox (i) \n');
for j=1:i;
    fprintf('%2d \t %11.7f \t %7.3f \n',j-1,fx(j),error(j));
end

