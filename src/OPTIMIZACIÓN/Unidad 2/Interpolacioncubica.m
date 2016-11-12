clear;
clc;
syms x X;
format long;
disp('Interpolación Cubica');
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES');
disp('x es la variable definida');
f=input('Ingrese la función:');
disp('Sus raices son:');
P=(diff(f,x));
pretty(vpa(solve(P)));
x1=input('Ingrese el VALOR PARA X1(-):  ');
x2=input('Ingrese el VALOR PARA X2(+):  ');
N=input('Ingrese el numero de iteraciones: ');
i=1;
x1(i)=x1  
x2(i)=x2
f1=vpa(subs(f,x,x1(i))) %%%% SUSTITUCIÓN EN FUNCION X1
f2=vpa(subs(f,x,x2(i))) %%%% SUSTITUCIÓN EN FUNCION X2 
f1_x1=vpa(subs(P,x,x1(i))) %%%% SUSTITUCIÓN EN PRIMERA DERIVADA X1
f1_x2=vpa(subs(P,x,x2(i))) %%%% SUSTITUCIÓN EN PRIMERA DERIVADA X2 
z= vpa(f1_x1 + f1_x2 + ((3*(f1-f2))/(x2(i) - x1(i))))
w= vpa((z^2 - (f1_x1*f1_x2))^(1/2))
X= vpa(x2(i) -((f1_x2 + w - z)/(f1_x2 - f1_x1 + 2*w))*(x2(i) - x1(i)))
A=vpa((x1(i)-X))
B=vpa((x2(i)-X))
while N>0
X= vpa(x2(i) -((f1_x2 + w - z)/(f1_x2 - f1_x1 + 2*w))*(x2(i) - x1(i)));
A=vpa((x1(i)-X));
B=vpa((x2(i)-X));
    if A>B %ENTONCES B ES EL MAS PEQUEÑO Y CORTAMOS AHI
    x1(i+1)=X;
    x2(i+1)=x2(i);
    f1=subs(f,x,x1(i+1)); %%%% SUSTITUCIÓN EN FUNCION X1
    f2=subs(f,x,x2(i+1)); %%%% SUSTITUCIÓN EN FUNCION X2 
    f1_x1=subs(P,x,x1(i+1)); %%%% SUSTITUCIÓN EN PRIMERA DERIVADA X1
    f1_x2=subs(P,x,x2(i+1)); %%%% SUSTITUCIÓN EN PRIMERA DERIVADA X2}
    z=f1_x1 + f1_x2 + ((3*(f1-f2))/(x2(i+1) - x1(i+1)));
    w=(z^2 - (f1_x1*f1_x2))^(1/2);
    i=i+1;
    elseif B>A
    x2(i+1)=X;
    x1(i+1)=x1(i);
    f1=subs(f,x,x1(i+1)); %%%% SUSTITUCIÓN EN FUNCION X1
    f2=subs(f,x,x2(i+1)); %%%% SUSTITUCIÓN EN FUNCION X2 
    f1_x1=subs(P,x,x1(i+1)); %%%% SUSTITUCIÓN EN PRIMERA DERIVADA X1
    f1_x2=subs(P,x,x2(i+1)); %%%% SUSTITUCIÓN EN PRIMERA DERIVADA X2
    z= f1_x1 + f1_x2 + ((3*(f1-f2))/(x2(i+1) - x1(i+1)));
    w=(z^2 - (f1_x1*f1_x2))^(1/2);
    i=i+1;
    end
N=N-1;
end 
fprintf('i          x1                 x2           \n');
for j=1:i;
    fprintf('%2d \t   %11.7f \t  %10f \t   \n',j-1,x1(j),x2(j));
end