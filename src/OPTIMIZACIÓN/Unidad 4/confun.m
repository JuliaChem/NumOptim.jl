function [c, ceq] = confun(x)
% restricciones de desigualdades lineales o no lineales
c = [-x(1); -x(2); -2*x(1)-4*x(2)+8; 2*x(1)-5*x(2); -x(1)+5*x(2)-5];
% restricciones de igualdades lineales o no lineales
ceq = []; 