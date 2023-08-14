mutable struct Course
    course_length::Int
    repetition::Int
    words::Vector{Int64}
    questions::Vector{String}
    answers::Vector{String}
    course_indices::Vector{Int}
    course_name::String
end

mutable struct TestResult
    courses::Vector{String}
    xp::Int
    accuracy::Float64
    learn_time::Int
end

mutable struct TestData
    mistakes::Dict{String, Dict{String, Any}}
    last_mistake_indices::Vector{Int}
end

course() = Course(0, 1, [], [], [], [], "")
test_result() = TestResult([], 0, 0.0, 0)
test_data() = TestData(Dict(), [0])