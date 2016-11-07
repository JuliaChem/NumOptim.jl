@doc """
       QuasiNewton method for local optimization (single variable)

       Supported by:
       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
 """ ->
function QuasiNewton(f, var; x0 = [1 2], error = 0.0001, maxiter = 100, iter = true)

      # Symbolic derivatives using Module SymPy
      dfk1 = diff(f, var)

      err = Inf
      i = 1
      xk = 0
      x_num = 0

      # Numeric iterations
      iter == true ? ti = time_ns() : nothing # To measure algorothm performance

      while err > error
            x_num = x0

            xk = x_num[2]-(N(dfk1 |> subs(x,x_num[2]))/(N(dfk1 |> subs(x,x_num[2])) -
                  N(dfk1 |> subs(x,x_num[1]))))*(x_num[2] - x_num[1])

            if xk > x_num[2]
                  err = abs(x_num[1] - xk)
                  x0 = [x_num[2] xk]

            elseif xk < x_num[1]
                  err = abs(x_num[2] - xk)
                  x0 = [xk x_num[1]]

            elseif xk < x_num[2] && xk > x_num[1]
                   err = abs(x_num[1] - xk)
                   x0 = [xk x_num[2]]
            end

                  if iter == true
                        if i == 1
                              println("===========================================================")
                              println(" QuasiNewton Solver for Unconstrained Optimization (0.0.2)")
                        end

                        if i == 1 || ceil((i/1)/10) == (i/1)/10
                              println("===========================================================")
                              @printf("Iter\t X\t\t f(x)\t\t |err|\n")
                              println("===========================================================")
                        end

                        @printf("%i\t %4.6e\t %4.6e\t %4.6e\n", i, xk, N(f |> subs(x,xk)), err)
                  end

            if i == maxiter
                  throw(ErrorException("Not Solved!. Iteration limit reached."))
                  break
            end

            i += 1
      end
      iter == true ? tf = time_ns() : nothing # To measure algorithm performance
      iter == true ? println("elapse time: ", (tf - ti)/1.0e9, " seconds") : nothing
      return xk,  N(f |> subs(x,xk))
end
