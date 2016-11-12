clear;
clc;
syms x;
format long;
disp('Interpolación Cuadratica');
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES');
disp('x es la variable definida');
f=input('Ingrese la función:');
disp('Sus raices son:');
U=diff(f,x);
pretty(vpa(solve(U)))
disp('Si sus raices no contiene un valor real, no tiene solución ...');
disp('pues sus raices son imaginarias ( ctrl+c )');
x1=input('Ingrese el VALOR PARA X1(-):  ');
x2=input('Ingrese el VALOR PARA X2(0):  ');
x3=input('Ingrese el VALOR PARA X3(+):  ');
N=input('Ingrese el numero de iteraciones: ');
i=1;
x1(i)=x1    
x2(i)=x2
x3(1)=x3 
f_1=vpa(subs(f,x,x1(i))) %%%% SUSTITUCIÓN EN F CON X1
f_2=vpa(subs(f,x,x2(i))) %%%% SUSTITUCIÓN EN F CON X2
f_3=vpa(subs(f,x,x3(i))) %%%% SUSTITUCIÓN EN F CON X3
A=vpa((((x2(i))^2)-(((x3(i))^2)))*f_1)
B=vpa((((x3(i))^2)-(((x1(i))^2)))*f_2)
C=vpa((((x1(i))^2)-(((x2(i))^2)))*f_3)
a=vpa(((x2(i))-(x3(i)))*f_1)
b=vpa(((x3(i))-(x1(i)))*f_2)
c=vpa(((x1(i))-(x2(i)))*f_3)
while N>0
X=.5*((A+B+C)/(a+b+c));
fX=subs(f,x,X);
if X<x3(i) && X>x2(i) %% SE ENCUENTRA ENTRE X2 Y X3
    if fX<f_2 && fX<f_3
        x1(i+1)=x2(i);
        x2(i+1)=X;
        x3(i+1)=x3(i);
        f_1=subs(f,x,x1(i+1)); %%%% SUSTITUCIÓN EN F CON X1
        f_2=subs(f,x,x2(i+1)); %%%% SUSTITUCIÓN EN F CON X2
        f_3=subs(f,x,x3(i+1)); %%%% SUSTITUCIÓN EN F CON X3
        A=(((x2(i+1))^2)-(((x3(i+1))^2)))*f_1; 
        B=(((x3(i+1))^2)-(((x1(i+1))^2)))*f_2; 
        C=(((x1(i+1))^2)-(((x2(i+1))^2)))*f_3; 
        a=((x2(i+1))-(x3(i+1)))*f_1;
        b=((x3(i+1))-(x1(i+1)))*f_2;
        c=((x1(i+1))-(x2(i+1)))*f_3;
        i=i+1;
    elseif fX>f_2 && fX<f_3
        x1(i+1)=x1(i);
        x2(i+1)=x2(i);
        x3(i+1)=X;
        f_1=subs(f,x,x1(i+1)); %%%% SUSTITUCIÓN EN F CON X1
        f_2=subs(f,x,x2(i+1)); %%%% SUSTITUCIÓN EN F CON X2
        f_3=subs(f,x,x3(i+1)); %%%% SUSTITUCIÓN EN F CON X3
        A=(((x2(i+1))^2)-(((x3(i+1))^2)))*f_1; 
        B=(((x3(i+1))^2)-(((x1(i+1))^2)))*f_2; 
        C=(((x1(i+1))^2)-(((x2(i+1))^2)))*f_3; 
        a=((x2(i+1))-(x3(i+1)))*f_1;
        b=((x3(i+1))-(x1(i+1)))*f_2;
        c=((x1(i+1))-(x2(i+1)))*f_3;
        i=i+1;
    end
elseif X<x2(i) && X>x1(i) %% SE ENCUENTRA ENTRE X1 Y X2
    if fX<f_2 && fX<f_1
        x1(i+1)=x1(i);
        x2(i+1)=X;
        x3(i+1)=x2(i);
        f_1=subs(f,x,x1(i+1)); %%%% SUSTITUCIÓN EN F CON X1
        f_2=subs(f,x,x2(i+1)); %%%% SUSTITUCIÓN EN F CON X2
        f_3=subs(f,x,x3(i+1)); %%%% SUSTITUCIÓN EN F CON X3
        A=(((x2(i+1))^2)-(((x3(i+1))^2)))*f_1; 
        B=(((x3(i+1))^2)-(((x1(i+1))^2)))*f_2; 
        C=(((x1(i+1))^2)-(((x2(i+1))^2)))*f_3; 
        a=((x2(i+1))-(x3(i+1)))*f_1;
        b=((x3(i+1))-(x1(i+1)))*f_2;
        c=((x1(i+1))-(x2(i+1)))*f_3;
        i=i+1;
    elseif fX>f_2 && fX<f_1
        x1(i+1)=X;
        x2(i+1)=x2(i);
        x3(i+1)=x3(i);
        f_1=subs(f,x,x1(i+1)); %%%% SUSTITUCIÓN EN F CON X1
        f_2=subs(f,x,x2(i+1)); %%%% SUSTITUCIÓN EN F CON X2
        f_3=subs(f,x,x3(i+1)); %%%% SUSTITUCIÓN EN F CON X3
        A=(((x2(i+1))^2)-(((x3(i+1))^2)))*f_1; 
        B=(((x3(i+1))^2)-(((x1(i+1))^2)))*f_2; 
        C=(((x1(i+1))^2)-(((x2(i+1))^2)))*f_3; 
        a=((x2(i+1))-(x3(i+1)))*f_1;
        b=((x3(i+1))-(x1(i+1)))*f_2;
        c=((x1(i+1))-(x2(i+1)))*f_3;
        i=i+1;
    end
elseif X>=x3(i)
    disp=('Error X es mayor que x3 o X1');
end
N=N-1;
end
fprintf('i          x1                 x2             x3       \n');
for j=1:i;
    fprintf('%2d \t   %11.7f \t  %10f \t   %9f\t   \n',j-1,x1(j),x2(j),x3(j));
end