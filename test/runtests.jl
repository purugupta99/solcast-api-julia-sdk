using SolcastAPI: API, Config, Error
using Test

monkey_patch_api_key = ENV["SOLCAST_API_KEY"] = ""

@test Config.version == "1.0.1"

@test_throws API.Error.ValueError API.check_params(Dict())