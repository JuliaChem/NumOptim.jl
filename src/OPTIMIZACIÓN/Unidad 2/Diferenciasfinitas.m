%% DIFERENCIAS FINITAS
clear;
clc;
syms x
disp('DIFERENCIAS FINITAS');
disp('x es la variable definida');
f=input('Ingrese la función:');
Ydx=(diff(f,x));
disp('La primera derivada es:');
pretty(Ydx)
disp('Sus raices son:');
pretty(vpa(solve(Ydx)));
disp('Si sus raices no contiene un valor real, no tiene solución ...');
disp('pues sus raices son imaginarias ( ctrl+c )');
x0=input('Ingrese el valor inicial: ');
h=input('Ingrese el valor de h: ');
tolerancia=input('Ingrese el porcentaje de error: ');
i=1;
fx(i)=x0;
h1=h;
FuncionmasH=vpa(subs(f,x,(fx(i))+h1))
FuncionmenosH=vpa(subs(f,x,(fx(i))-h1))
FuncionenX=vpa(subs(f,x,(fx(i))))
f1=vpa(((subs(f,x,(fx(i))+h1)) - (subs(f,x,(fx(i))-h1)))/(2*h1))
d=vpa(((subs(f,x,(fx(i))+h1)) + (subs(f,x,(fx(i))-h1)) - (2*(subs(f,x,fx(i)))))/(h1^2))
error(1)=100;
while abs(error(i)) >= tolerancia
    fx(i+1)=fx(i)-(f1/d);
    f1=((subs(f,x,(fx(i+1))+h1)) - (subs(f,x,(fx(i+1))-h1)))/(2*h1);
    d=((subs(f,x,(fx(i+1))+h1)) + (subs(f,x,(fx(i+1))-h1)) - (2*(subs(f,x,fx(i+1)))))/(h1^2);
    error(i+1)=abs((fx(i+1)-fx(i))/fx(i+1)*100);
    i=i+1;
end
fprintf('i      fx(i)      Error aprox (i) \n');
for j=1:i;
    fprintf('%2d \t %11.7f \t %7.3f \n',j-1,fx(j),error(j));
end
