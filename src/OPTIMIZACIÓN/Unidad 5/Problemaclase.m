clear
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
syms x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 l
clc
format short
disp('METODO GRG')
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES')
fx = (x1 -1)^2 + (x1 - x2)^2 + (x2 - x3)^2 + (x3 - x4)^4 + (x4 - x5)^4;   %función para maximizar o minimizar
h(1) = x1 + x2^2 + x3^3 - 2 - (3*(2^(1/2))) ;
h(2) = x2 + x3^2 + x4   + 2 - (2*(2^(1/2))) ;
h(3) = x1*x5 - 2;
xi={x1 x5};
xd={x2 x3 x4};
xx_var={x1 x2 x3 x4 x5};
Xo={1,3,5,7,9};
tam=length(xi);
tem=length(xd);
for i=1:tam  %% 
      dfx_dxI(:,i)=diff(fx,xi(i));
end
for i=1:tem  %% 
      dfx_dxd(:,i)=diff(fx,xd(i));
end
for j=1:length(h)
    for i=1:tam  %%
      dh_dxI(j,i)=diff(h(j),xi(i));
    end
end
for j=1:length(h)
    for i=1:tem  %% 
      dh_dxd(j,i)=diff(h(j),xd(i));
    end
end
dfx_dxI
dfx_dxd
dh_dxI
dh_dxd
Gr=(dfx_dxI')-(dh_dxI')*(transpose((inv(dh_dxd))))*(dfx_dxd')
%Substitutir el valor de x1 x2 y x3 en Gr
vxEp=vpa(subs(Gr,{x1,x2,x3,x4,x5},Xo))
% %Busca del incremento
DELTAI=-vxEp;
DELTAD= subs(-(inv(dh_dxd))*(dh_dxI)*DELTAI,{x1,x2,x3,x4,x5},Xo) 
%CALCULO DE DELTA D
syms x1 x2 l
y1=x1 + (l*DELTAI(1,1));  %RESPECTO A X1 
y2=x2 + (l*DELTAI(2,1));  %RESPECTO A X2
y3=x3 + (l*DELTAD(1,1));  %RESPECTO A X3 
y4=x4 + (l*DELTAD(2,1));  %RESPECTO A X4
y5=x5 + (l*DELTAD(3,1));  %RESPECTO A X5
FUNCION=vpa(simplify(subs(subs(fx,{x1,x2,x3,x4,x5},{y1,y2,y3,y4,y5}),{x1,x2,x3,x4,x5},{1,3,5,7,9})));
RAICES=solve(FUNCION)
%RAICES = (RAICES.*conj(RAICES)).^0.5
% ESTIMACION DE XI Y XD 
Lambda= abs(min(RAICES))
XI= xi' + -.1*(Lambda)*(DELTAI);
XD= xd' + -.1*(Lambda)*(DELTAD);
XI=subs(XI,{x1,x2,x3,x4,x5},Xo);  %ESTIMACION DE XI
XD=subs(XD,{x1,x2,x3,x4,x5},Xo);  %ESTIMACION DE XD
XD1=XD;
% evaluacion de h
for i=1:length(h)
Hrest(i,:)=vpa(subs(h(i),{x1,x2,x3,x4,x5},{XI(1,1),XI(2,1),XD(1,1),XD(2,1),XD(3,1)}));
end
%Metodo de Newton
err1=1;
i=0;
while err1>=0.00000001
for j=1:length(h)
    for i=1:tem  %% 
      dh_dxd(j,i)=diff(h(j),xd(i));
    end
end
dh_dxd=inv(subs(dh_dxd,{x1,x2,x3,x4,x5},{XI(1,1),XI(2,1),XD(1,1),XD(2,1),XD(3,1)}))';
for i=1:length(h)
Hr(i,:)=vpa(subs(h(i),{x1,x2,x3,x4,x5},{XI(1,1),XI(2,1),XD(1,1),XD(2,1),XD(3,1)}));
end
Xdk= XD - ((dh_dxd))*Hr;
err1= abs((XD-Xdk));
XD(1,1)=Xdk(1,1);
XD(2,1)=Xdk(2,1);
XD(3,1)=Xdk(3,1);
i=i+1;
if i==20
%     Lambda= Lambda - (1/2)*Lambda;
%     % EMPEZAR LA FASE 3 NUEVAMENTE
%     Valord1=0;
    break;
elseif i<20
%     Valord1=1;
end
end
XI
XD
Xnueva=[XI(1,1),XI(2,1),XD(1,1),XD(2,1),XD(3,1)];
Xorign=[XI(1,1),XI(2,1),XD1(1,1),XD1(2,1),XD1(3,1)];
F_Xnueva=subs(fx,{x1,x2,x3,x4,x5},{XI(1,1),XI(2,1),XD(1,1),XD(2,1),XD(3,1)})
F_Xorign=subs(fx,{x1,x2,x3,x4,x5},{XI(1,1),XI(2,1),XD1(1,1),XD1(2,1),XD1(3,1)})
%% FASE 6 ___________ CRITERIOS DE CONVERGENCIA
for i=1:length(Xnueva) %RESTRICCIONES DEL PUNTO FACTIBLE DE -2 A 2 
    if Xnueva(i)>=-100 && Xnueva(i)<=100
    VectorSiNo(i,:)=1;
    else
    VectorSiNo(i,:)=0;
    end
end
VectorSiNo=sum(VectorSiNo)


