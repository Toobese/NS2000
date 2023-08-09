include("open_courses.jl")
include("storage.jl")

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
init_functions["kanji_japanese"] = initialize_language("words/hiragana_katakana/kanji.txt")
init_functions["kanji_english"] = initialize_language("words/hiragana_katakana/english.txt")
init_functions["N5_japanese"] = initialize_language("words/jp_N5_kanji/kanji.txt")
init_functions["N5_english"] = initialize_language("words/jp_N5_kanji/english.txt")
init_functions["N5_jp_vocab"] = initialize_language("words/jp_N5_vocabulary/kanji.txt")
init_functions["N5_en_vocab"] = initialize_language("words/jp_N5_vocabulary/english.txt")
init_functions["N5_jp_kanji"] = initialize_language("words/jp_N5_kana/kanji.txt")
init_functions["N5_jp_kana"] = initialize_language("words/jp_N5_kana/kana.txt")


