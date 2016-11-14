using OptimJulia
using Base.Test
using SymPy

x = Sym("x")

f = ((((1 - 8x) + 2*x^2) - (10/3)*x^3) + (1/4)*x^4 + (4/5)*x^5) - (1/6)*x^6

Newton(f, x, 3)

x1,x2 = Sym("x1,x2")
vars = [x1,x2]
f = -log(1 - x1 - x2) - log(x1) - log(x2)
x0 = [0.85,0.05]

Newton(f, vars, x0)

 for i = 2:10
       QuasiNewton(f, x, x0 = [i i+4])
       println("=========================================")
       println("Test $i with QuasiNewton algorithm passed")
 end
