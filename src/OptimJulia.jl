module OptimJulia
using Calculus

export Newton
export Quasi-Newton

include("Newton.jl")
include("Quasi-Newton.jl")

end
