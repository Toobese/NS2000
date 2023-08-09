mutable struct Course
    course_length::Int
    repetition::Int
    languages::Vector{String}
    language_names::Vector{Vector{String}}
    progress_score::Vector{String}
    chosen_path::String
end

mutable struct TestResult
    courses::Vector{String}
    xp::Int
    accuracy::Float64
    learn_time::Int
end

mutable struct Language
    words::Vector{Vector{String}}
end

course() = Course(0, 
                  1,
                  ["Japanese", "Swedish", "hiragana_katakana", "N5_kanji", "jp_N5_vocabulary", "jp_N5_kana"],
                  [["jp_english", "jp_japanese", "japanese"], 
                   ["sw_dutch", "sw_swedish", "pinhok"], 
                   ["kanji_japanese", "kanji_english", "hiragana_katakana"], 
                   ["N5_japanese", "N5_english", "jp_N5_kanji"],
                   ["N5_jp_vocab", "N5_en_vocab", "jp_N5_vocabulary"],
                   ["N5_jp_kanji", "N5_jp_kana", "jp_N5_kana"]],
                  [],
                  ""
                  )
test_result() = TestResult([], 0, 0.0, 0)