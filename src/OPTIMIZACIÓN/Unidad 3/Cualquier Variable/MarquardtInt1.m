clear
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
syms x11 x12 x13 x14 x15 x16 x17 x18 x19 x20
clc
format short
% PASO 1
disp('METODO DE MARQUARDT PARA CUALQUIER VARIABLE')
disp('OPTIMIZACIÓN POR METODOS DETERMINISTICOS')
fx =  5*x1^2 + x2^2 + 2*x1*x2 - 12*x1 - 4*x2 + 8
xx = {x1,x2} 
xi = [-1 -3]
disp(' ')
iter = 1;
lambda = 1E4;
disp('Jacobiano')
vx = jacobian(fx);
disp(vx)
disp('Hessian')
hx = hessian(fx);
disp(hx)
err = 100;
error = 0.01;
% Conteo del n?mero de variables 
tam = length(xx);
% Impresi?n de cabeceras 
msg = cell(1, (2*tam + 3));
msg{1,1} = sprintf('Iter\t');
% IMPRIMIR NUMERO DE ITERACIONES i
for i=1:tam
msg{1,i+1} = [msg{1,i} sprintf('x%ik\t\t',i)];
end
% IMPRIMIR NUMERO DE ITERACIONES j
i = i + 2;
msg{1,i} = [msg{1,i-1} sprintf('f(xk)\t\t')];
for j=1:tam
msg{1,i+j} = [msg{1,i + j -1} sprintf('x%i(k+1)\t\t',j)];
end
msg{1,(i+j+1)} = [msg{1,i+j} sprintf('fx(k+1)\n')];
disp(msg{1,end})
% Condiciones para iniciar ambos ciclos
a = 1;
b = 1;
while a == 1
    % Paso 2
    % Evaluacion de la funcion con vxE (Jacobiano)
    for i=1:tam
        if i == 1
            vxEp = eval(subs(vx,xx{i},xi(i)));
        else
            vxEp = eval(subs(vxEp,xx{i},xi(i)));
        end
    end
    % Paso 3
%if sum(abs(vxEp) > error) >= 1
    % Paso 4
    while b == 1
        % Calculo de S(x) y xk
        % Evaluaci?n del jacobiano
        for i=1:tam
            if i == 1
                vxE = eval(subs(vx,xx{i},xi(i)));
            else
                vxE = eval(subs(vxE,xx{i},xi(i)));
            end
        end

        % Evaluaci?n de la hessian
        for i=1:tam
            if i == 1
                hxE = eval(subs(hx,xx{i},xi(i)));
            else
                hxE = eval(subs(hxE,xx{i},xi(i)));
            end
        end
        S = - inv(hxE + lambda * eye(tam)) * vxE';
        xk = xi' + S;


        % Evaluaci?n de la funci?n con fxk
        for i=1:tam
            if i == 1
                fxE = eval(subs(fx,xx{i},xi(i)));
            else
                fxE = eval(subs(fxE,xx{i},xi(i)));
            end
        end

        % Evaluaci?n de la funci?n con fxk+1
        for i=1:tam
            if i == 1
                fxkE = eval(subs(fx,xx{i},xk(i)));
            else
                fxkE = eval(subs(fxkE,xx{i},xk(i)));
            end
        end

        msg = cell(1, (2*tam + 3));
        msg{1,1} = sprintf('%i\t', iter);

        for i=1:tam
        msg{1,i+1} = [msg{1,i} sprintf('%f\t',xi(i))];
        end

        i = i + 2;
        msg{1,i} = [msg{1,i-1} sprintf('%f\t', fxE)];

        for j=1:tam
        msg{1,i+j} = [msg{1,i + j -1} sprintf('%f\t',xk(j))];
        end

        msg{1,(i+j+1)} = [msg{1,i+j} sprintf('%f',fxkE)];
        disp(msg{1,end})

        if abs(fxkE - fxE) < 0.001
            a = 0;
            break
        end
        
        if fxkE < fxE
            % Paso 6
            lambda = 0.5 * lambda;
            xi = xk';
            iter = iter + 1;
            break
        else
            % Paso 7
            lambda = 2 * lambda;
            xi = xk';
            iter = iter + 1;
        end
    end
  %  else
    % Segunda parte del Paso 3
    % Terminar c?lculo porque ya se encuentra en los puntos ?ptimos
    % break
end
%end

