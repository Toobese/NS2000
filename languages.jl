include("open_courses.jl")
include("structs.jl")

init_functions = Dict{String, Function}()

function get_language(name::String, courses::Vector{String})
    return init_functions[name](courses)
end

function initialize_language(file_path::String)
    function (courses::Vector{String})
        words = open_courses(file_path, courses)
        Language(words)
    end
end

init_functions["jp_english"] = initialize_language("words/japanese/english.txt")
init_functions["jp_japanese"] = initialize_language("words/japanese/japanese.txt")
init_functions["sw_dutch"] = initialize_language("words/pinhok/nederlands.txt")
init_functions["sw_swedish"] = initialize_language("words/pinhok/svenska.txt")
