using OptimJulia
using Base.Test

# write your own tests here

f = :(((((1 - 8x) + 2 * x ^ 2) - (10 / 3) * x ^ 3) + (1 / 4) * x ^ 4 + (4 / 5) * x ^ 5) - (1 / 6) * x ^ 6)

for x0 = 1:10
      Newton(f, x0)
end
