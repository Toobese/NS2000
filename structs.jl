mutable struct course
    course_count    ::Int
    course_length   ::Int
    REPETITION      ::Int
    course_indices  ::Vector{Int64}
end

mutable struct test_result
    courses     ::Vector{String}
    xp          ::Int
    accuracy    ::Float64
    learn_time  ::Int
    source      ::String
end

mutable struct Language
    words::Vector{Vector{String}}
end

course() = course(2, 0, 2, [])
test_result() = test_result([], 0, 0.0, 0, "")