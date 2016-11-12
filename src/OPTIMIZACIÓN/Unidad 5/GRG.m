clear
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
syms x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 l
clc
format short
disp('METODO GRG')
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES')
fx = (2*x1 - (.5*x1^2))+(3*x2 - (.5*x2^2));   %función para maximizar o minimizar
xx(1) = x1^2 + x2^2 + x3 -1  ;
xx_var = {x1,x2,x3};
% Rest=length(xx)
tum=length(xx_var);
%Condiciones iniciales de las restricciones y funcion
Xo=[.5 .5 .5];
%Condiciones iniciales para la funcion
%Numero de variables
%Definir las variables dependientes e independientes
xi={x1 x3};
xd={x2};
%FASE 1 ______________ ESTRUCTURA DEL GRADIENTE
tam=length(xi);
tem=length(xd);
for i=1:tam  %% 
      dfxdxI(:,i)=diff(fx,xi(i));
end
for i=1:tem  %% 
      dfdxd(:,i)=diff(fx,xd(i));
end
for i=1:tam  %% 
      dhdxI(:,i)=diff(xx,xi(i));
end
for i=1:tem  %% 
      dhdxITrans(:,i)=diff(xx,xd(i));
end
Hrest=1;
%% FASE1 ____________ DELTA I
[DELTAI]=fase1(dfxdxI,dhdxI,dhdxITrans,dfdxd,xx_var,Xo)
%% FASE2 ____________ RAICES DE LA FUNCION
[XI,XD,XD1,Lambda,DELTAD]=fase2(dhdxITrans,dhdxI,DELTAI,xx_var,Xo,fx,xi,xd)
% EVALUAR LA RESTRICCIÓN O RESTRICCIONES
Hrest=subs(xx,xx_var,{XI(1,1),XD(1,1),XI(2,1)}); %LINEA A MODIFICAR SIEMPRE
%% FASE 4 ___________ METODO DE NEWTON RAPSON 
[XD,Lambda,Valord1]=NewtonRapson(xx,xd,xx_var,XI,XD,Lambda)
%% FASE 5 ___________ EVALUACIÓN DE LAS FUNCIONES CON LOS PUNTOS
Xnueva=[XI(1,1),XD(1,1),XI(2,1)]; % LINEA A MODIFICAR SIEMPRE
Xorign=[XI(1,1),XD1(1,1),XI(2,1)]; % LINEA A MODIFICAR SIEMPRE
F_Xnueva=subs(fx,xx_var,Xnueva);
F_Xorign=subs(fx,xx_var,Xorign);
%% FASE 6 ___________ CRITERIOS DE CONVERGENCIA
for i=1:length(Xnueva) %RESTRICCIONES DEL PUNTO FACTIBLE DE -2 A 2 
    if Xnueva(i)>=-2 && Xnueva(i)<=2
    VectorSiNo(i,:)=1;
    else
    VectorSiNo(i,:)=0;
    end
end
VectorSiNo=sum(VectorSiNo);
if length(Xnueva)==VectorSiNo
    if F_Xnueva<F_Xorign
        Xo=Xnueva
        % SE EMPIEZA DE NUEVO DESDE LA FASE 1
        [DELTAI]=fase1(dfxdxI,dhdxI,dhdxITrans,dfdxd,xx_var,Xo)
        [XI,XD,XD1,Lambda,DELTAD]=fase2(dhdxITrans,dhdxI,DELTAI,xx_var,Xo,fx,xi,xd)
        Hrest=subs(xx,xx_var,{XI(1,1),XD(1,1),XI(2,1)});
        [XD,Lambda,Valord1]=NewtonRapson(xx,xd,xx_var,XI,XD,Lambda)
        Xnueva=[XI(1,1),XD(1,1),XI(2,1)]; % LINEA A MODIFICAR SIEMPRE
        Xorign=[XI(1,1),XD1(1,1),XI(2,1)]; % LINEA A MODIFICAR SIEMPRE
        F_Xnueva=subs(fx,xx_var,Xnueva);
        F_Xorign=subs(fx,xx_var,Xorign);
    elseif F_Xnueva>F_Xorign
        % SE REDUCE ALFA POR UN FACTOR DE 1/10 
        % SE EMPIEZA EN LA FASE 3 
        Lambda= Lambda - (1/10)*Lambda
        % EMPEZAR FASE 3 NUEVAMENTE 
        [XD,Lambda,Valord1]=NewtonRapson(xx,xd,xx_var,XI,XD,Lambda)
    else
        Valord2=0;
        if Valord1==0 && Valord2==0
        %ES NECESARIO ESTIMAS DED NUEVO LAS VARIABLES 
        %DEPENDIENTES Y LAS INDEPENDIENTES
        syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
        syms x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 l
        xi=input('Dame las variables de xi entre {}: ');
        xd=input('Dame las variables de xd entre {}: ');
        end
    end
end



