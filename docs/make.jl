using Documenter
using Solcast

makedocs(
    root=".",
    source="docs/src",
    build="docs/build",
    sitename="Solcast.jl",
    checkdocs=:none,
    modules = [Solcast],
    pages = [
        "Home" => "index.md",
        "Forecast" => "forecast.md",
        "Live" => "live.md",
        "Historic" => "historic.md",
        "Tmy" => "tmy.md",
        "API Reference" => [
            "Client" => "api/client.md",
            "Response" => "api/response.md",
        ]
    ]

)