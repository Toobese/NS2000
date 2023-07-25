include("open_courses.jl")
include("structs.jl")


init_functions = Dict{String, Function}()

function get_language(name::String)
    return init_functions[name]()
end


function initialize_language(words::Vector{Vector{Any}})
    function ()
        Language(words)
    end
end

init_functions["jp_english"] = initialize_language(open_courses("words/japanese/english.txt"))
init_functions["jp_japanese"] = initialize_language(open_courses("words/japanese/japanese.txt"))
init_functions["sw_dutch"] = initialize_language(open_courses("words/pinhok/nederlands.txt"))
init_functions["sw_swedish"] = initialize_language(open_courses("words/pinhok/svenska.txt"))
