@doc """
       Newton method for local optimization (multivariable variable)

       Supported by:

       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
       GitHub: Kelvyn88

       Eng. Gabriel Hernández Morales
       e-mail: gabo1178@hotmail.com
 """ ->

function Newton(f, vars; x0 = 1, error = 0.0001, maxiter = 100, iter = true)
      try
            err = Inf
            count = 1
            x_num = 0
            f_num = f

            # Numeric iterations
            iter == true ? ti = time_ns() : nothing # To measure algorithm performance

            while err > error
                  x_num = x0

                  # Symbolic derivatives using Module SymPy
                  if length(vars) == 0
                        dfk = diff(f)
                  else
                        dfk = Array(SymPy.Sym, 1, length(vars))
                        for i=1:length(vars)
                              dfk[i] = diff(f, vars[i])
                        end
                  end

                  f_num = f

                  # Symbolic hessian using Module SymPy
                  if length(vars) == 0
                        dfk2 = diff(dfk)
                  else
                        hess = hessian(f, vars)
                  end

                  # Numeric evaluations
                  if length(vars) == 0
                        dfk = dfk |> subs(vars, x_num)
                        dfk2 = dfk2 |> subs(vars,x_num)
                  else
                        for i=1:length(vars), j=1:length(vars), k=1:length(vars)
                              dfk[i] = dfk[i] |> subs(vars[k], x_num[k])
                              hess[i,j] = hess[i,j] |> subs(vars[k],x_num[k])
                        end
                  end

                  # Newton equation
                  if length(vars) == 0
                        xk = x_num - N(dfk)/N(dfk2)
                  else
                        xk = x_num - inv(hess) * transpose(dfk)
                  end

                  err = sum(abs((N(xk) -  x_num) ./ N(xk)))

                  # Numeric evaluation of original function
                  if length(vars) == 0
                        f_num = f_num |> subs(vars, N(xk))
                  else
                        for k=1:length(vars)
                              f_num = f_num |> subs(vars[k], N(xk[k]))
                        end
                  end

                  xk = N(xk)
                  err = N(err)
                  f_num = N(f_num)

                  # Print iteration for the case of iter == true
                  if iter == true
                        if count == 1
                              println("======================================================")
                              println(" Newton Solver for Unconstrained Optimization (0.0.2)")
                        end

                        if count == 1 || ceil((count/1)/10) == (count/1)/10
                              println("======================================================")
                              @printf("Iter\t X\t\t f(x)\t\t |err|\n")
                              println("======================================================")
                        end
                        @printf("%i\t %4.6e\t %4.6e\t %4.6e\n", count, xk[1], f_num, err)
                  end

                  # Backup of new data for next iteration
                  x0 = xk
                  x_num = xk
                  count += 1

                  if count == maxiter
                        throw(ErrorException("Not Solved!. Iteration limit reached."))
                  end
            end

            println("======================================================")
            println(" ")

            iter == true ? tf = time_ns() : nothing # To measure algorithm performance
            iter == true ? println("elapse time: ", (tf - ti)/1.0e9, " seconds") : nothing

            return x_num,  f_num, err

      catch Msg
            println("======================================================")
            println(Msg)
            return NaN, NaN, NaN
      end
end
