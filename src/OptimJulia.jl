module OptimJulia
      using SymPy

      export Newton
      export QuasiNewton

      include("Newton.jl")
      include("QuasiNewton.jl")

end
