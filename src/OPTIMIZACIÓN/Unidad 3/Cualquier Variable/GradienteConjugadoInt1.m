clear
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
syms x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
clc
format short
disp('NEWTON MULTIVARIABLE PARA n VARIABLES')
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
    for i=1:tam  %% CALCULO DEL JACOBIANO
        if i == 1
            vxEp = eval(subs(vx,xx{i},xi(i)));
        else
            vxEp = eval(subs(vxEp,xx{i},xi(i)));
        end
    end
disp('Sko inicial de busqueda:')
SK0=-vxEp'
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
    LAMBDA= -((vxEp*SK0)/(SK0'*hxE*SK0)) %%CALCULO DE LA LAMBDA
    yi = xi' + LAMBDA*SK0 %%CALCULO DE LOS NUEVOS VALORES
    disp('Valores de la función con valores recalculados');
    for i=1:tam  %% FUNCIÓN EVALUADA
        if i == 1
            fxeval = eval(subs(fx,xx{i},yi(i)));
        else
            fxeval = eval(subs(fxeval,xx{i},yi(i)));
        end
    end
    disp(fxeval)
    for i=1:tam  %% CALCULO DEL NUEVO JACOBIANO
        if i == 1
            vxEpy = eval(subs(vx,xx{i},yi(i)));
        else
            vxEpy = eval(subs(vxEpy,xx{i},yi(i)));
        end
    end
    disp('Nuevo sector de busqueda');
    SK0= -vxEpy' + SK0*((vxEpy*vxEpy')/(vxEp*vxEp'))
    disp('Valores nuevos recalculados');
    xi=yi'
    N=N-1;
end