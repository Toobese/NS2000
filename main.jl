using Random
using Dates
include("structs.jl")
include("languages.jl")
include("write_to_file.jl")
include("test_words.jl")


function main()
        c = course()
        t = test_result()
        question_lan = get_language("jp_english")
        answer_lan = get_language("jp_japanese")

        println("Choose a course, or have 2 random courses\n" *
                "The courses should be separated by ;")
        
        ans = readline()
        courses = split(ans, ';')
        if all([all(isdigit, i) for i in courses]) &&
                all(i -> i <= length(question_lan.words), [parse(Int, i) for i in courses])
                c.course_indices = [parse(Int, i) for i in courses]
                c.course_count = length(c.course_indices)
        else
                c.course_indices = sort(shuffle(eachindex(question_lan.words))[1:c.course_count])
        end
        c.course_length = sum([length(question_lan.words[i]) for i in c.course_indices])

        word_sequence = shuffle([i for i in 1:(c.course_length) for _ in 1:c.REPETITION])
        question_words = reduce(vcat, [question_lan.words[i] for i in c.course_indices])
        answer_words = reduce(vcat, [answer_lan.words[i] for i in c.course_indices])

        print_course(c.course_indices)

        t.mistakes, total_tests = word_test(question_words, answer_words, word_sequence)
        t.xp = c.course_length * c.REPETITION
        t.accuracy = round(xp / total_tests, digits=3)
        t.learn_time = xp * 5

        write_to_file(t, "progress")
        write_to_file(t, "mistakes")
end

function print_course(course_indices)
        println("-" ^ 15)
        for i in course_indices
                printstyled("Course $(i): Words $(1+(i-1)*25)-$(i * 25)\n", color=:magenta)
        end
        println("-" ^ 15)
end

main()