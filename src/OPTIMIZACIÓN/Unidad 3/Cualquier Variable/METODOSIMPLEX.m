clc;
clear;
format short 
syms x1 x2 x3 real
disp('METODO SIMPLEX')
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES')
f(1,1)= 5*x1^2 + x2^2 + 2*x1*x2 - 12*x1 - 4*x2   
n=input('Numero de variables: ');
alpha=input('Valor inicial para alpha: ');
X1=input('Dame el valor para X1: ');
X2=input('Dame el valor para X2: ');
N=input('Dame el valor de las maximas iteraciones: '); 
Xo=[X1 X2];
d1=alpha*(((n+1)^(.5) + n -1)/(n*(2^(.5))));
d2=alpha*(((n+1)^(.5) -1)/(n*(2^(.5))));
Y1=Xo'+[d2;d1]; 
x_11=Y1(1,1);
x_12=Y1(2,1);
Y2=Xo'+[d1;d2];
y_11=Y2(1,1);
y_12=Y2(2,1);
Fx0=vpa(subs(f,{x1 x2},{X1 X2}));
Fx1=vpa(subs(f,{x1 x2},{x_11 x_12}));
Fx2=vpa(subs(f,{x1 x2},{y_11 y_12}));
Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]))
Triangulo1=[X1 x_11 y_11 ];
Triangulo2=[X2 x_12 y_12 ];
plot(Triangulo1,Triangulo2,'g')
xlabel('Valores de X1');
ylabel('Valores de X2');
grid on
hold on
while N>=0
ValorReflejado=input('QUE FUNCION REFLEJARAS fx0=1 fx1=2 fx2=3 o alpha=4 :');
    if ValorReflejado==1
        Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]));
        Val1=Valores(1,2:3)';
        Val2=Valores(2,2:3)';
        Val3=Valores(3,2:3)';
        NuevaX=Val2+Val3-Val1;
        Fx0=Fx1;
        X1=x_11;
        X2=x_12;
        Fx1=Fx2;
        x_11=y_11;
        x_12=y_12;
        y_11=NuevaX(1,1);
        y_12=NuevaX(2,1);
        Fx2=vpa(subs(f,{x1 x2},{y_11 y_12}));
        Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]))
        Triangulo1=[X1 x_11 y_11];
        Triangulo2=[X2 x_12 y_12];
        plot(Triangulo1,Triangulo2,'g')
        hold on
    elseif ValorReflejado==2
        Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]));
        Val1=Valores(1,2:3)';
        Val2=Valores(2,2:3)';
        Val3=Valores(3,2:3)';
        NuevaX=Val3+Val1-Val2;
        Fx0=Fx0;
        X1=X1;
        X2=X2;
        Fx1=Fx2;
        x_11=y_11;
        x_12=y_12;
        y_11=NuevaX(1,1);
        y_12=NuevaX(2,1);
        Fx2=vpa(subs(f,{x1 x2},{y_11 y_12}));
        Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]))
        Triangulo1=[X1 x_11 y_11];
        Triangulo2=[X2 x_12 y_12];
        plot(Triangulo1,Triangulo2,'r')
        hold on
    elseif ValorReflejado==3
        Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]));
        Val1=Valores(1,2:3)';
        Val2=Valores(2,2:3)';
        Val3=Valores(3,2:3)';
        NuevaX=Val1+Val2-Val3;
        y_11=NuevaX(1,1);
        y_12=NuevaX(2,1);
        Fx2=vpa(subs(f,{x1 x2},{y_11 y_12}));
        Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]))
        Triangulo1=[X1 x_11 y_11];
        Triangulo2=[X2 x_12 y_12];
        plot(Triangulo1,Triangulo2,'g')
    elseif ValorReflejado==4
    alpha=input('Valor nuevo para alpha: ');
    X1=input('Dame el valor de X1 para la nueva iteración: ');
    X2=input('Dame el valor de X2 para la nueva iteración: ');
    Xo=[X1 X2];
    d1=alpha*(((n+1)^(.5) + n -1)/(n*(2^(.5))));
    d2=alpha*(((n+1)^(.5) -1)/(n*(2^(.5))));
    Y1=Xo'+[d2;d1]; 
    x_11=Y1(1,1);
    x_12=Y1(2,1);
    Y2=Xo'+[d1;d2];
    y_11=Y2(1,1);
    y_12=Y2(2,1);
    Fx0=vpa(subs(f,{x1 x2},{X1 X2}));
    Fx1=vpa(subs(f,{x1 x2},{x_11 x_12}));
    Fx2=vpa(subs(f,{x1 x2},{y_11 y_12}));
    Valores=vpa(([Fx0 X1 X2;Fx1 x_11 x_12;Fx2 y_11 y_12]))
    Triangulo1=[X1 x_11 y_11 ];
    Triangulo2=[X2 x_12 y_12 ];
    plot(Triangulo1,Triangulo2,'r')
    hold on
    end
    N=N-1;
end






