@doc """
       Newton method for local optimization (multivariable)

       Supported by:

       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
       GitHub: Kelvyn88
""" ->

function RandomSearch(f, vars, lb, up; maxiter = 100, iter = true)
      #try
            const version = Pkg.installed("OptimJulia")
            length(vars) == 0 ? len = 1 : len = length(vars)

            length(vars) == 0 ? sep_var = 1 : sep_var = length(vars)
            const separator = "="^(9 + (sep_var + 2)*16)

            # Initial values
            maxfn = 0
            varX = zeros(1,len)
            varXX = zeros(1,len)

            # Numeric iterations
            iter == true ? ti = time_ns() : nothing # To measure algorithm performance

            for i=1:maxiter
                  # Numeric evaluations for simbolic variables
                  for j=1:len
                        varX[j] = lb[j] + (up[j] - lb[j])*rand()
                  end

                  fn = f
                  for i=len
                        fn = fn |> subs(vars[i], varX[i])
                        println(fn)

                  end
                  println(typeof(fn))
                  fn = convert(Float32, fn)
                  if fn > maxfn
                        maxfn = fn
                        varsXX = varX
                  end
            end

            println(maxfn)
      #catch Msg
      #      println(separator)
      #      println(Msg)
      #      return NaN, NaN, NaN
      #end
end
