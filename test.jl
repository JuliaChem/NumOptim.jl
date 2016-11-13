using SymPy

x1,x2 = Sym("x1,x2")

vars = [x1,x2]

f = -log(1 - x1 - x2) - log(x1) - log(x2)

x0 = [0.85,0.05]
