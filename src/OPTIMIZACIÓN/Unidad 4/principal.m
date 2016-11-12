%Programa de ejemplo de utilización de funciones del toolbox de
%optimización en MATLAB
%Realizado por:- Marchena Williams
% - Ornelas Carlos
%Supervizado por: Gonzalez-Longatt, F.
%Fecha: 12-02-2006
%UNEFA - Núcleo Maracay
%-----------------------------------------------------------------
clc % Borra la pantalla
clear % Borra todas las variables
disp(' ') % DISP: muestra una cadena de caracteres
disp(' Ejemplo 1')
disp('------------------------------------------------------------')
disp(' Condiciones Iniciales')
x0=[-1,1]
options=optimset('LargeScale','off');
[x,fval]=fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options)

%--------------------------------------------------------------------- 