#%% SETUP
# ======================================
#  CEE 492 - Bridge Scour Analysis
#  Julia Model setup
# ======================================

import Pkg
Pkg.activate(@__DIR__)    # activate the environment where THIS file lives
Pkg.instantiate()         # ensure packages are installed

# --- Load packages ---
using CSV
using DataFrames
using Statistics
using StatsBase
using Plots
using StatsPlots
using LinearAlgebra

#%% PATH SETUP

# Path to the Data folder (relative to this file)
const DATADIR = joinpath(@__DIR__, "Data")

# Make sure it exists
if !isdir(DATADIR)
    error("Data directory not found: $DATADIR")
end

println("Data directory confirmed at: ", DATADIR)
println("Files in Data/: ", readdir(DATADIR))

#%% LOAD DATA

file = "BridgeScourSites_MT_CrossSections_2012.csv"
path = joinpath(DATADIR, file)

df = CSV.read(path, DataFrame)

println("Loaded file: ", file)
println("Rows: ", size(df, 1), " | Columns: ", size(df, 2))
first(df, 5)