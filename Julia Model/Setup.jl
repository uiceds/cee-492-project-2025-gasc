import Pkg
Pkg.activate(@__DIR__)  # or Pkg.activate(".") if you cd'ed into the folder
Pkg.add(["CSV","DataFrames","StatsBase","Plots","StatsPlots"])