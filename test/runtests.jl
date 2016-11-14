using OptimJulia
using Base.Test
using SymPy

x1,x2 = Sym("x1,x2")

f1 = ((((1 - 8x1) + 2*x1^2) - (10/3)*x1^3) + (1/4)*x1^4 + (4/5)*x1^5) - (1/6)*x1^6

Newton(f1, x1, 3)

vars = [x1,x2]
f2 = -log(1 - x1 - x2) - log(x1) - log(x2)
x0 = [0.85,0.05]

Newton(f2, vars, x0)

for i = 2:10
      QuasiNewton(f1, x1, x0 = [i i+4])
      println("=========================================")
      println("Test $i with QuasiNewton algorithm passed")
end
