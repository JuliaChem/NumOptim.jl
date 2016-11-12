clear
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
syms x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
clc
format short
disp('NEWTON MULTIVARIABLE N VARIABLES')
disp('DESARROLLADO POR GABRIEL HERNÁNDEZ MORALES')
N=input('Dame el valor de las maximas iteraciones: '); 
fx =  5*x1^2 + x2^2 + 2*x1*x2 - 12*x1 - 4*x2 
xx = {x1,x2}
xi = [-1 -3]
tam = length(xx)
disp('Jacobiano')
vx = jacobian(fx)
disp('Hessian')
hx = hessian(fx)
while N>0
    for i=1:tam  %% CALCULO DEL JACOBIANO
        if i == 1
            vxEp = eval(subs(vx,xx{i},xi(i)));
        else
            vxEp = eval(subs(vxEp,xx{i},xi(i)));
        end
    end
        % CALCULO DE LA HESSIANA
    for i=1:tam
        if i == 1
           hxE = eval(subs(hx,xx{i},xi(i)));
        else
           hxE = eval(subs(hxE,xx{i},xi(i)));
        end
    end
C=(inv(hxE))*vxEp';     
valores= xi' - C;
disp('Valores de la función con valores recalculados');
    for i=1:tam  %% FUNCIÓN EVALUADA
        if i == 1
            fxeval = eval(subs(fx,xx{i},valores(i)));
        else
            fxeval = eval(subs(fxeval,xx{i},valores(i)));
        end
    end
disp(fxeval)
disp('Valores nuevos recalculados');
xi=valores'
N=N-1;
end

        
        
        
        
        
        
        