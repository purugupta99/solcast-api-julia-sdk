module SolcastAPI

export Forecast, Historic, Live, Tmy

include("forecast.jl")
include("historic.jl")
include("live.jl")
include("tmy.jl")

end # module SolcastAPI
