@doc """
       Newton method for local optimization (multivariable)

       Supported by:

       Ph D Kelvyn B. Sánchez
       e-mail: kelvyn.baruc@gmail.com
       GitHub: Kelvyn88
""" ->

function RandomSearch(f, vars, lb, up; maxiter = 100, iter = true)
      try
            const version = Pkg.installed("OptimJulia")
            length(vars) == 0 ? len = 1 : len = length(vars)

            length(vars) == 0 ? sep_var = 1 : sep_var = length(vars)
            const separator = "="^(9 + (sep_var + 2)*16)

            # Initial values
            maxfn = 0
            varX = zeros(1,len)
            varXX = zeros(1,len)
            count = 1

            # Numeric iterations
            iter == true ? ti = time_ns() : nothing # To measure algorithm performance

            for i=1:maxiter
                  fn = f
                  # Numeric evaluations for simbolic variables
                  for j=1:len
                        varX[j] = lb[j] + (up[j] - lb[j])*rand()
                        fn = subs(fn, vars[j], varX[j])
                  end

                  fn = convert(Float32, fn)
                  if fn > maxfn
                        maxfn = fn
                        varXX = varX
                  end

                  # Print iteration for the case of iter == true
                  if iter == true
                        if count == 1
                              # Header message and version
                              println(separator)
                              msg1 = @sprintf(" RandomSearch Solver for Optimization %s ", version)
                              msg2 = @sprintf(" Ph D Kelvyn B. Sánchez ")
                              header_left = ceil((length(separator) - length(msg1))/2)
                              header_right = (length(separator) - length(msg1)) - header_left
                              msg1_left = ":"^convert(Int32,header_left)
                              msg1_right = ":"^convert(Int32,header_right)
                              msg1 = string(msg1_left, msg1, msg1_right)
                              println(msg1)

                              header_left = ceil((length(separator) - length(msg2))/2)
                              header_right = (length(separator) - length(msg2)) - header_left
                              msg2_left = ":"^convert(Int32,header_left)
                              msg2_right = ":"^convert(Int32,header_right)
                              msg2 = string(msg2_left, msg2, msg2_right)
                              println(msg2)
                        end

                        if count == 1 || ceil((count/1)/10) == (count/1)/10
                              println(separator)

                              # Header
                              msg1 = "Iter\t "

                              for i=1:len
                                    msg1 = string(msg1, vars[i], "\t\t ")
                              end

                              msg1 = string(msg1, "f(x)\t\t")
                              println(msg1)
                              println(separator)
                        end

                        # Custom message for iterator
                        msg2 = @sprintf("%i\t ", count)
                        for i=1:len
                              msg2 = string(msg2, @sprintf("%4.6e\t ", varX[i]))
                        end

                        msg2 = string(msg2, @sprintf("%4.6e\t ", fn))
                        println(msg2)
                  end
                  count += 1

            end

            iter == true ? println(separator) : nothing
            iter == true ? tf = time_ns() : nothing # To measure algorithm performance
            iter == true ? println("elapse time: ", (tf - ti)/1.0e9, " seconds") : nothing

            return [varX, maxfn]
      catch Msg
            println(separator)
            println(Msg)
            return NaN, NaN, NaN
      end
end
