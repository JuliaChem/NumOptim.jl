%% CODIGO PARA VARIABLES ELEVADAS AL CUADRADO (DOS VARIABLES)
clc;
clear;
syms x1 x2 
fx= 3 + 2*x1 + 3*x2 + 3*x2 + 2*x1^2 + 2*x1*x2 + 6*x2^2; 
disp('Primera dervidad respecto a x1:');
df1x1=diff(fx,x1)
disp('Primera derivada respecto a x2:');
df2x2=diff(fx,x2)
disp('Segunda derivada respecto a x1 y x1:')
df2x1x1=diff(fx,x1,x1) %%Segunda derivada con respeccto a x1
disp('Segunda derivada respecto a x1 y x2:')
df2x1x2=diff(fx,x1,x2) %%Segunda derivada con respecto a x1 y x2
disp('Segunda derivada respecto a x2 y x1:')
df2x2x1=diff(fx,x2,x1) %%Segunda derivada con respecto a x2 y x1
disp('Segunda derivada respecto a x2 y x2:')
df2x2x2=diff(fx,x2,x2) %%Segunda derivada con respecto a x2 y x2
disp('La matriz hessiana, determinante y egenvalores:');
H=[df2x1x1 df2x1x2;df2x2x1 df2x2x2];
pretty(H)
detH=det(H)
val=eig((H))
%% CODIGO PARA 3 VARIABLES 
clc;
clear;
syms x1 x2 x3
fx= 3*x1^2 + 6*x1 + x2^2 + 6*x1*x2 + x3 + 2*x3^2 + x2*x3 + x2
disp('Primera dervidad respecto a x1:');
df1x1=diff(fx,x1)
disp('Primera derivada respecto a x2:');
df2x2=diff(fx,x2)
disp('Primera derivada respecto a x3:');
df2x3=diff(fx,x3)
disp('Segunda derivada respecto a x1 y x1:')
df2x1x1=diff(fx,x1,x1) %%Segunda derivada con respeccto a x1
disp('Segunda derivada respecto a x1 y x2:')
df2x1x2=diff(fx,x1,x2) %%Segunda derivada con respecto a x1 y x2
disp('Segunda derivada respecto a x1 y x3:')
df2x1x3=diff(fx,x1,x3) %%Segunda derivada con respecto a x1 y x2
disp('Segunda derivada respecto a x2 y x1:')
df2x2x1=diff(fx,x2,x1) %%Segunda derivada con respecto a x2 y x1
disp('Segunda derivada respecto a x2 y x2:')
df2x2x2=diff(fx,x2,x2) %%Segunda derivada con respecto a x2 y x2
disp('Segunda derivada respecto a x2 y x2:')
df2x2x3=diff(fx,x2,x3) %%Segunda derivada con respecto a x2 y x3
disp('Segunda derivada respecto a x3 y x1:')
df2x3x1=diff(fx,x3,x1)
disp('Segunda derivada respecto a x3 y x2:')
df2x3x2=diff(fx,x3,x2)
disp('Segunda derivada respecto a x3 y x3:')
df2x3x3=diff(fx,x3,x3)
disp('La matriz hessiana, determinante y egenvalores:');
H=[df2x1x1 df2x1x2 df2x1x3;df2x2x1 df2x2x2 df2x2x3;df2x3x1 df2x3x2 df2x3x3];
pretty(H)
determinante=det(H)
egenvalores=vpa(eig((H))
%% CODIGO PARA 4 VARIABLES 
clc;
clear;
syms x1 x2 x3 x4
fx= 3*x1^2 + 6*x1 + x2^2 + 6*x1*x2 + x3 + 2*x3^2 + x2*x3 + 2*x2*x4
disp('Primera dervidad respecto a x1:');
df1x1=diff(fx,x1)
disp('Primera derivada respecto a x2:');
df2x2=diff(fx,x2)
disp('Primera derivada respecto a x3:');
df2x3=diff(fx,x3)
disp('Primera derivada respecto a x3:');
df2x4=diff(fx,x4)
disp('Segunda derivada respecto a x1 y x1:')
df2x1x1=diff(fx,x1,x1) %%Segunda derivada con respeccto a x1
disp('Segunda derivada respecto a x1 y x2:')
df2x1x2=diff(fx,x1,x2) %%Segunda derivada con respecto a x1 y x2
disp('Segunda derivada respecto a x1 y x3:')
df2x1x3=diff(fx,x1,x3) %%Segunda derivada con respecto a x1 y x3
disp('Segunda derivada respecto a x1 y x4:')
df2x1x4=diff(fx,x1,x4) %%Segunda derivada con respecto a x1 y x4
disp('Segunda derivada respecto a x2 y x1:')
df2x2x1=diff(fx,x2,x1) %%Segunda derivada con respecto a x2 y x1
disp('Segunda derivada respecto a x2 y x2:')
df2x2x2=diff(fx,x2,x2) %%Segunda derivada con respecto a x2 y x2
disp('Segunda derivada respecto a x2 y x3:')
df2x2x3=diff(fx,x2,x3) %%Segunda derivada con respecto a x2 y x3
disp('Segunda derivada respecto a x2 y x4:')
df2x2x4=diff(fx,x2,x4) %%Segunda derivada con respecto a x2 y x4
disp('Segunda derivada respecto a x3 y x1:')
df2x3x1=diff(fx,x3,x1)
disp('Segunda derivada respecto a x3 y x2:')
df2x3x2=diff(fx,x3,x2)
disp('Segunda derivada respecto a x3 y x3:')
df2x3x3=diff(fx,x3,x3)
disp('Segunda derivada respecto a x3 y x3:')
df2x3x4=diff(fx,x3,x4)
disp('Segunda derivada respecto a x4 y x1:')
df2x4x1=diff(fx,x4,x1)
disp('Segunda derivada respecto a x4 y x2:')
df2x4x2=diff(fx,x4,x2)
disp('Segunda derivada respecto a x4 y x3:')
df2x4x3=diff(fx,x4,x3)
disp('Segunda derivada respecto a x4 y x3:')
df2x4x4=diff(fx,x4,x4)
disp('La matriz hessiana, determinante y egenvalores:');
H=[df2x1x1 df2x1x2 df2x1x3 df2x1x4;df2x2x1 df2x2x2 df2x2x3 df2x2x4;df2x3x1 df2x3x2 df2x3x3 df2x3x4;df2x4x1 df2x4x2 df2x4x3 df2x4x4];
pretty(H)
determinante=det(H)
egenvalores=vpa(eig((H)))

