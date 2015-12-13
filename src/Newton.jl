using Calculus
function Newton(f; x0 = 1, error = 0.000001, maxiter = 100, iter = true)

      # Symbolic derivatives
      dfk1 = differentiate(f)
      dfk2 = differentiate(dfk1)

      # Convert to function from derivative::expression
      @eval function df1(x)
            $dfk1
      end

      @eval function df2(x)
            $dfk2
      end

      @eval function fx(x)
            $f
      end

      err = Inf
      i = 1
      x = 0
      # Numerical iterations
      while err > error
            x = x0

            xk = x - df1(x) / df2(x)
            err = abs((xk - x) / xk)

                  if iter == true
                        if i == 1
                              @printf("Iter\t X\t\t f(x)\t\t error\n")
                        end
                        @printf("%i\t %4.6e\t %4.6e\t %4.6e\n", i, xk, fx(xk), err)


                  end

            if i == maxiter
                  break
            end
            x0 = xk
            x = xk
            i += 1
      end
      return x, fx(x)
end
