module OptimJulia
using Calculus

export Newton
export QuasiNewton

include("Newton.jl")
include("QuasiNewton.jl")

end
