@doc """
       Newton method for local optimization (multivariable variable)

       Supported by:

       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
       GitHub: Kelvyn88

       Eng. Gabriel Hernández Morales
       e-mail: gabo1178@hotmail.com
       GitHub: Gabo1178
""" ->

f(x, y) = y - x - 2*x^2 - 2*x*y - y^2

lb = [-2 1]
up = [2 3]

maxfn = 0
maxx = 0
maxy = 0
for i=1:2000
      x = lb[1] + (up[1] - lb[1])*rand()
      y = lb[2] + (up[2] - lb[2])*rand()
      fn = f(x, y)
      if fn > maxfn
            maxfn = fn
            maxx = x
            maxy = y
      end
end

println("f($(maxx),$(maxy)) = $(maxfn)")
