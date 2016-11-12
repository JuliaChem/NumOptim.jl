function [XI,XD,XD1,Lambda,DELTAD]=fase2(dh_dxI,dh_dxd,DELTAI,fx,xi,xd,Xo)
DELTAD= subs((inv(dh_dxd))*(dh_dxI)*DELTAI,{x1,x2,x3,x4,x5},Xo) 
%CALCULO DE DELTA D
syms x1 x2 x3 x4 x5 l
y1=x1 + (l*DELTAI(1,1));  %RESPECTO A X1 
y2=x2 + (l*DELTAI(2,1));  %RESPECTO A X2
y3=x3 + (l*DELTAD(1,1));  %RESPECTO A X3 
y4=x4 + (l*DELTAD(2,1));  %RESPECTO A X4
y5=x5 + (l*DELTAD(3,1));  %RESPECTO A X5
FUNCION=vpa(simplify(subs(subs(fx,{x1,x2,x3,x4,x5},{y1,y2,y3,y4,y5}),{x1,x2,x3,x4,x5},Xo)));
RAICES=solve(FUNCION)
%RAICES = (RAICES.*conj(RAICES)).^0.5
% ESTIMACION DE XI Y XD 
Lambda= abs(max(RAICES))
XI= xi' + (Lambda)*(DELTAI);
XD= xd' + (Lambda)*(DELTAD);
XI=subs(XI,{x1,x2,x3,x4,x5},{1,3,5,7,9});  %ESTIMACION DE XI
XD=subs(XD,{x1,x2,x3,x4,x5},{1,3,5,7,9});  %ESTIMACION DE XD
XD1=XD;