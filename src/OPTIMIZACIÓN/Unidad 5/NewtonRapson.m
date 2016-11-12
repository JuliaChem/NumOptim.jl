function [XD,Lambda,Valord1]=NewtonRapson(h,tem,xd,XI,XD,Lambda)
syms x1 x2 x3 x4 x5
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
    Lambda= Lambda - (1/2)*Lambda;
    % EMPEZAR LA FASE 3 NUEVAMENTE
    Valord1=0;
    break;
elseif i<20
    Valord1=1;
end
end
