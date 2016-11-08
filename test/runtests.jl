using OptimJulia
using Base.Test
using SymPy

x = Sym("x")

f = ((((1 - 8x) + 2*x^2) - (10/3)*x^3) + (1/4)*x^4 + (4/5)*x^5) - (1/6)*x^6

for i = 1:10
      Newton(f, x, x0 = i)
      println("=========================================")
      println("Test $i with Newton algorithm passed")
end

 for i = 2:10
       QuasiNewton(f, x, x0 = [i i+4])
       println("=========================================")
       println("Test $i with QuasiNewton algorithm passed")
 end
