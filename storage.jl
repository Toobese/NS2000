mutable struct Course
    course_length::Int
    repetition::Int
    words::Vector{Int64}
    questions::Vector{String}
    answers::Vector{String}
    course_indices::Vector{Int}
end

mutable struct TestResult
    courses::Vector{String}
    xp::Int
    accuracy::Float64
    learn_time::Int
end

course() = Course(0, 1, [], [], [], [])
test_result() = TestResult([], 0, 0.0, 0)