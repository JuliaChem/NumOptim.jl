%% Cuasi Newton
clear;
clc;
syms x
disp('Cuasi Newton');
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES');
disp('x es la variable definida')
f=input('Ingrese la función:');
z=(diff(f,x));
disp('La primera derivada es:');
pretty(z)
disp('Sus raices son:');
pretty(vpa(solve(z)))
reals=vpa(solve(z));
disp('Si sus raices no contiene un valor real, no tiene solución ...');
disp('pues sus raices son imaginarias ( ctrl+c )');
xq1=input('Ingrese el valorinicial de xq (VALOR POSITIVO): ');
xp1=input('Ingrese el valor inicial de xp (VALOR NEGATIVO): ');
N=input('Ingrese el numero de iteraciones maximas: '); 
i=1;
xq(i)=xq1    %%%%%% SIGNO POSITIVO
xp(i)=xp1     %%%%%% SIGNO NEGATIVO
f1_xq=vpa(subs(z,x,xq(i))) %%%% SUSTITUCIÓN EN POSITIVO
f1_xp=vpa(subs(z,x,xp(i))) %%%% SUSTITUCIÓN EN NEGATIVO %% NUMERO DE ITERACIONES MAXIMAS
while (N>0)
X = xq(i)- ((f1_xq)/((f1_xq - f1_xp)/(xq(i)- xp(i))));
if reals(1,1) <= X
    xq(i+1)=X; 
    xp(i+1)=xp(i);
    f1_xq=subs(z,x,xq(i+1)); %%% SUSTITUCIÓN EN POSITIVO
    f1_xp=subs(z,x,xp(i+1)); %%% SUSTITUCIÓN EN NEGATIVO
    i=i+1;
elseif reals(1,1) >= X
    xq(i+1)=xq(i);
    xp(i+1)=X;
    f1_xq=subs(z,x,xq(i+1));   %%% SUSTITUCIÓN EN POSITIVO
    f1_xp=subs(z,x,xp(i+1));   %%% SUSTITUCIÓN EN NEGATIVO
    i=i+1;
end
N=N-1;
end
fprintf('i          xp                 xq              \n');
for j=1:i;
    fprintf('%2d \t   %11.7f \t  %10f \t    \n',j-1,xp(j),xq(j));
end