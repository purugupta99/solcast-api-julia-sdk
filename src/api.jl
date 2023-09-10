module API

include("error.jl")
include("config.jl")

using HTTP
using JSON

struct Response
    status_code::Int64
    url::String
    data::Union{Vector{UInt8}, Nothing}
    success::Bool
    exception::Union{String, Nothing}
end

function to_dict(response::Response)
    if response.success
        return JSON.parse(String(response.data))
    else
        throw(invalid_response_error)
    end
end

struct Client
    base_url::String
    endpoint::String
    user_agent::String
end

# Generates the full URL
make_url(client::Client) = client.base_url * client.endpoint

# Generates the user agent
user_agent = "solcast-api-julia-sdk/" * version

# Validates the parameters
function check_params(params::Dict)
    # Validates that the params dictionary has an api_key
    if !haskey(params, "api_key")
        if haskey(ENV, "SOLCAST_API_KEY")
            params["api_key"] = ENV["SOLCAST_API_KEY"]
        else
            throw(ValueError(
                """
                no API key provided. Either set it as an environment \
                variable SOLCAST_API_KEY, or provide `api_key` \
                as an argument. Visit https://solcast.com to get an API key.
                """
            ))
        end
    end

    #Validates the length of the API key
    if length(params["api_key"]) <= 1
        throw(ValueError("API key is too short."))
    end

    # Joins the output parameters into a comma-separated string if the "output_parameters" key is present
    if haskey(params, "output_parameters") && isa(params["output_parameters"], Array)
        params["output_parameters"] = join(params["output_parameters"], ",")
    end

    # Rounds the latitude and longitude to 6 decimal places if they are present
    if haskey(params, "latitude")
        params["latitude"] = round(params["latitude"], digits=6)
    end

    if haskey(params, "longitude")
        params["longitude"] = round(params["longitude"], digits=6)
    end

    # Validates that the format is json
    if haskey(params, "format")
        @assert params["format"] == "json" "only json response format is currently supported."
    end

    println(length(params["api_key"]))
    println("Checking params... ",  params)

    key = params["api_key"]
    delete!(params, "api_key")

    return params, key
end

# Gets the data from the API service and returns a Response object
function get_response(client::Client, params::Dict)
    params, key = check_params(params)
    url = make_url(client)

    println("URL: ", url)
    println("Params: ", params)
    println("Key: ", key)

    headers = Dict("Authorization" => "Bearer $key", "User-Agent" => client.user_agent)

    response_object = nothing
    try
        response = HTTP.get(url, headers, query=params)

        if HTTP.status(response) == 200
            response_object = Response(
                response.status,
                string(response.request.url),
                response.body,
                true,
                nothing
            )
        else
            response_object = Response(
                response.status,
                string(response.request.url),
                response.body,
                false,
                "HTTP status code: " * string(response.status)
            )
        end

    catch e
        response_object = Response(
            0,
            url,
            nothing,
            false,
            string(e)
        )
    end
    # println("Response: ", response.body)
    println(response_object)

    return response_object
end

export Response, Client, to_dict, make_url, check_params, get_response, user_agent
end