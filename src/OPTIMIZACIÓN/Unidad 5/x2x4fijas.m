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
xi={x2 x4};
xd={x1 x3 x5};
xx_var={x1 x2 x3 x4 x5};
Xo={5.0020,-1.3378,-.8184,1.4956,.3998};
XI1=[-1.3378,1.4956]';
XD1=[5.0020,-.8184,.3998]';
% Xo={5.2231,-1.3441,-.8659,1.4955,.3829};
% XI1=[-1.3441,1.4955]';
% XD1=[5.2231,-.8659,.3829]';
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
Gr=(dfx_dxI')-(dh_dxI')*(transpose((inv(dh_dxd))))*(dfx_dxd');
vxEp=vpa(subs(Gr,{x1,x2,x3,x4,x5},Xo));
DELTAI=-vxEp;
DELTAD= subs(-(inv(dh_dxd))*(dh_dxI)*DELTAI,{x1,x2,x3,x4,x5},Xo);
%CALCULO DE DELTA D
syms x1 x2 l
y1=x1 + (l*DELTAD(1,1));  %RESPECTO A X1 
y2=x2 + (l*DELTAI(1,1));  %RESPECTO A X2
y3=x3 + (l*DELTAD(2,1));  %RESPECTO A X3 
y4=x4 + (l*DELTAI(2,1));  %RESPECTO A X4
y5=x5 + (l*DELTAD(3,1));  %RESPECTO A X5
FUNCION=vpa(simplify(subs(subs(fx,{x1,x2,x3,x4,x5},{y1,y2,y3,y4,y5}),xx_var,Xo)));
RAICES=solve(FUNCION);
% ESTIMACION DE XI Y XD 
Lambda= abs(real(min(RAICES)))
XI= xi' + (Lambda)*(DELTAI);
XD= xd' + (Lambda)*(DELTAD);
XI=subs(XI,xx_var,Xo)  %ESTIMACION DE XI
XD=subs(XD,xx_var,Xo) %ESTIMACION DE XD
%Metodo de Newton
err1=1;
i=0;
while err1>=0.00000001
for j=1:length(h)
    for i=1:tem  %% 
      dh_dxd(j,i)=diff(h(j),xd(i));
    end
end
dh_dxd=inv(subs(dh_dxd,{x1,x2,x3,x4,x5},{XD(1,1),XI(1,1),XD(2,1),XI(2,1),XD(3,1)}));
for i=1:length(h)
Hr(i,:)=vpa(subs(h(i),{x1,x2,x3,x4,x5},{XD(1,1),XI(1,1),XD(2,1),XI(2,1),XD(3,1)}));
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
    break;
elseif i<20
%     Valord1=1;
end
end
Xnueva=[XD(1,1),XI(1,1),XD(2,1),XI(2,1),XD(3,1)]'
Xorign=[XD1(1,1),XI1(1,1),XD1(2,1),XI1(2,1),XD1(3,1)]'
F_Xnueva=vpa(subs(fx,{x1,x2,x3,x4,x5},{XD(1,1),XI(1,1),XD(2,1),XI(2,1),XD(3,1)}))
F_Xorign=vpa(subs(fx,{x1,x2,x3,x4,x5},Xo))
for i=1:length(h)
Hrest(i,:)=vpa(subs(h(i),xx_var,{XD(1,1),XI(1,1),XD(2,1),XI(2,1),XD(3,1)}))
end