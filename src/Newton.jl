@doc """
       Newton method for local optimization (multivariable variable)

       Supported by:

       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
       GitHub: Kelvyn88

       Eng. Gabriel Hernández Morales
       e-mail: gabo1178@hotmail.com
 """ ->

function Newton(f::SymPy.Sym, var::Vector{SymPy.Sym}; x0 = 1, error = 0.0001, maxiter = 100, iter::Bool = true)
      try
            # Symbolic derivatives using Module SymPy
            dfk = Array(SymPy.Sym, 1, length(vars))
            for i=1:length(vars)
                  dfk[i] = diff(f, vars[i])
            end

            # Symbolic hessian using Module SymPy
            hess = hessian(f, vars)

            err = Inf
            i = 1
            x_num = 0

            # Numeric iterations
            iter == true ? ti = time_ns() : nothing # To measure algorithm performance

            while err > error
                  x_num = x0
                  hess_num = hess
                  dfk_num = dfk

                  for i=1:length(vars)
                        dfk_num[i] = dfk_num[i] |> subs(vars[i], x_num[i])
                        for j=1:length(vars)
                              hess_num[i,j] = hess_num[i,j] |> subs(vars[j],x_num[j])
                        end
                  end
                  

                  xk = x_num - inv(hess_num) * dfk_num
                  err = sum(abs((xk -  N(var |> subs(var,x_num))) ./ xk))

                        if iter == true
                              if i == 1
                                    println("======================================================")
                                    println(" Newton Solver for Unconstrained Optimization (0.0.2)")
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
                  end
            end

            println("======================================================")
            println(" ")

            iter == true ? tf = time_ns() : nothing # To measure algorithm performance
            iter == true ? println("elapse time: ", (tf - ti)/1.0e9, " seconds") : nothing

            return x_num,  N(f |> subs(var,x_num))

      catch Msg
            println("======================================================")
            println(Msg)
            return NaN, NaN
      end
end
