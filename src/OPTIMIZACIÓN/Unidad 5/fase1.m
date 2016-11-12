function [DELTAI]=fase1(dfx_dxI,dh_dxI,dh_dxd,dfx_dxd,Xo)
Gr=(dfx_dxI')-(dh_dxI')*(transpose((inv(dh_dxd))))*(dfx_dxd')
%Substitutir el valor de x1 x2 y x3 en Gr
vxEp=vpa(subs(Gr,{x1,x2,x3,x4,x5},Xo))
% %Busca del incremento
DELTAI=-vxEp;