@doc """
       Newton method for local optimization (single variable)

       Supported by:
       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
 """ ->

function Newton(f, var; x0 = 1, error = 0.0001, maxiter = 100, iter = true)
      try
            # Symbolic derivatives using Module SymPy
            dfk1 = diff(f, var)
            dfk2 = diff(dfk1, var)

            err = Inf
            i = 1
            x_num = 0

            # Numeric iterations
            iter == true ? ti = time_ns() : nothing # To measure algorothm performance

            while err > error
                  x_num = x0

                  xk = N(var |> subs(var,x_num)) - N(dfk1 |> subs(var, x_num)) / N(dfk2 |> subs(var, x_num))
                  err = abs((xk -  N(var |> subs(var,x_num))) / xk)

                        if iter == true
                              if i == 1
                                    println("======================================================")
                                    println(" Newton Solver for Unconstrained Optimization (0.0.2)")
                                    println(" ")
                              end

                              if i == 1 || ceil((i/1)/10) == (i/1)/10
                                    println("======================================================")
                                    @printf("Iter\t X\t\t f(x)\t\t |err|\n")
                                    println("======================================================")
                              end

                              @printf("%i\t %4.6e\t %4.6e\t %4.6e\n", i, xk, N(f |> subs(var,x_num)), err)
                        end

                  x0 = xk
                  x_num = xk
                  i += 1

                  if i == maxiter
                        throw(ErrorException("Not Solved!. Iteration limit reached."))
                        return NaN, NaN
                  end
            end
            iter == true ? tf = time_ns() : nothing # To measure algorithm performance
            iter == true ? println("elapse time: ", (tf - ti)/1.0e9, " seconds") : nothing

            return x_num,  N(f |> subs(var,x_num))

      catch Msg
            println(Msg)
            return NaN, NaN
      end
end
