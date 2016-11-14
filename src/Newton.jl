@doc """
       Newton method for local optimization (multivariable variable)

       Supported by:

       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
       GitHub: Kelvyn88

       Eng. Gabriel Hernández Morales
       e-mail: gabo1178@hotmail.com
       GitHub: Gabo1178
 """ ->

function Newton(f, vars, x0; error = 0.0001, maxiter = 100, iter = true)
      try
            const version = Pkg.installed("OptimJulia")
            length(vars) == 0 ? len = 1 : len = length(vars)

            length(vars) == 0 ? sep_var = 1 : sep_var = length(vars)
            const separator = "="^(9 + (sep_var + 2)*16)
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
                        # Single variable
                        dfk = diff(f)
                  else
                        # Multivariable variable
                        dfk = Array(SymPy.Sym, 1, length(vars))
                        for i=1:length(vars)
                              dfk[i] = diff(f, vars[i])
                        end
                  end

                  f_num = f

                  # Symbolic hessian using module SymPy
                  if length(vars) == 0
                        # Single variable
                        dfk2 = diff(dfk)
                  else
                        # Multivariable variable
                        hess = hessian(f, vars)
                  end

                  # Numeric evaluations
                  if length(vars) == 0
                        # Single variable
                        dfk = dfk |> subs(vars, x_num)
                        dfk2 = dfk2 |> subs(vars,x_num)

                        # Conversion from BigInt to Float32 (avoid overflow)
                        dfk = convert(Float32, dfk)
                        dfk2 = convert(Float32, dfk2)
                  else
                        # Multivariable variable
                        for i=1:length(vars), j=1:length(vars), k=1:length(vars)
                              dfk[i] = dfk[i] |> subs(vars[k], x_num[k])
                              hess[i,j] = hess[i,j] |> subs(vars[k],x_num[k])
                        end

                        # Conversion from BigInt to Float32 (avoid overflow)
                        dfk = convert(Array{Float32,length(vars)}, dfk)
                        hess = convert(Array{Float32,length(vars)}, hess)
                  end

                  # Newton equation
                  if length(vars) == 0
                        # Single variable
                        xk = x_num - dfk/dfk2
                  else
                        # Multivariable variable
                        xk = x_num - inv(hess) * transpose(dfk)
                  end

                  err = sum(abs((xk -  x_num) ./ xk))

                  # Numeric evaluation of original function
                  for k=1:len
                        f_num = f_num |> subs(vars[k], N(xk[k]))
                  end

                  f_num = convert(Float32, f_num)

                  # Print iteration for the case of iter == true
                  if iter == true
                        if count == 1
                              # Header message and version
                              println(separator)
                              msg1 = @sprintf(" Newton Solver for Unconstrained Optimization %s ", version)
                              header_left = ceil((length(separator) - length(msg1))/2)
                              header_right = (length(separator) - length(msg1)) - header_left
                              msg1_left = ":"^convert(Int32,header_left)
                              msg1_right = ":"^convert(Int32,header_right)
                              msg1 = string(msg1_left, msg1, msg1_right)
                              println(msg1)
                        end

                        if count == 1 || ceil((count/1)/10) == (count/1)/10
                              println(separator)

                              # Header
                              msg1 = "Iter\t "

                              for i=1:len
                                    msg1 = string(msg1, vars[i], "\t\t ")
                              end

                              msg1 = string(msg1, "f(x)\t\t ","||err||\t\t ")
                              println(msg1)
                              println(separator)
                        end

                        # Custom message for iterator
                        msg2 = @sprintf("%i\t ", count)
                        for i=1:len
                              msg2 = string(msg2, @sprintf("%4.6e\t ", xk[i]))
                        end

                        msg2 = string(msg2, @sprintf("%4.6e\t ", f_num), @sprintf("%4.6e", err))
                        println(msg2)
                  end

                  # Backup of new data for next iteration
                  x0 = xk
                  x_num = xk
                  count += 1

                  if count == maxiter
                        throw(ErrorException("Not Solved!. Iteration limit reached."))
                  end
            end

            iter == true ? println(separator) : nothing
            iter == true ? tf = time_ns() : nothing # To measure algorithm performance
            iter == true ? println("elapse time: ", (tf - ti)/1.0e9, " seconds") : nothing

            return x_num,  f_num, err

      catch Msg
            println(separator)
            println(Msg)
            return NaN, NaN, NaN
      end
end
