@doc """
       QuasiNewton method for local optimization (single variable)

       Supported by:
       -PhD Kelvyn B. Sánchez
       -MSc Lorena S. Galicia 
 """ ->
function QuasiNewton(f; x0 = [1 2], error = 0.0001, maxiter = 100, iter = true)

      # Symbolic derivatives
      dfk1 = differentiate(f)

      # Convert expression to function
      @eval function fx(x)
            $f
      end

      # Convert to function from derivative::expression
      @eval function df1(x)
            $dfk1
      end

      err = Inf
      i = 1
      x = 0 # Needed for global variable
      xk = 0

      # Numerical iterations
      while err > error
            x = x0

            xk = x[2]-(df1(x[2])/(df1(x[2]) - df1(x[1]))*(x[2] - x[1]))

            if xk > x[2]
                  err = abs(x[1] - xk)
                  x0 = [x[2] xk]
            elseif xk < x[1]
                  err = abs(x[2] - xk)
                  x0 = [xk x[1]]

            elseif xk < x[2] && xk > x[1]
                   err = abs(x[1] - xk)
                   x0 = [xk x[2]]
            end

                  if iter == true
                        if i == 1
                              @printf("Iter\t X\t\t f(x)\t\t |err|\n")
                              println("======================================================")
                        end
                        @printf("%i\t %4.6e\t %4.6e\t %4.6e\n", i, xk, fx(xk), err)
                  end

            if i == maxiter
                  break
            end

            i += 1
      end
      return xk, fx(xk)
end
