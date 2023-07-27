mutable struct Course
    course_length::Int
    REPETITION::Int
    categories::Vector{String}
    languages::Vector{String}
    language_names::Vector{Vector{String}}
end

mutable struct TestResult
    courses::Vector{String}
    xp::Int
    accuracy::Float64
    learn_time::Int
    source::String
end

mutable struct Language
    words::Vector{Vector{String}}
end

course() = Course(0, 2,
                ["Pronounces", "People", "Body", "Family", "Animals",
                 "Plants", "Crops", "Food", "Drink", "Seasoning", "Time"],
                 ["Japanese", "Swedish"],
                 [["jp_english", "jp_japanese"], ["sw_dutch", "sw_swedish"]])
test_result() = TestResult([], 0, 0.0, 0, "")