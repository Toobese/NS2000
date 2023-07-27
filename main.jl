using Random
using Dates
include("structs.jl")
include("languages.jl")
include("write_to_file.jl")
include("test_words.jl")
include("menu_creation.jl")


function main()
        c = course()
        t = test_result()
        
        language = show_selection_menu(c.languages, "language", c)
        courses = show_selection_menu(c.categories, "course(s)", c)
        question_lan = get_language(language[1], courses)
        answer_lan = get_language(language[2], courses)

        c.course_length = sum([length(words) for words in question_lan.words])

        word_sequence = shuffle([i for i in 1:(c.course_length) for _ in 1:c.REPETITION])
        question_words = reduce(vcat, [questions for questions in question_lan.words])
        answer_words = reduce(vcat, [answers for answers in answer_lan.words])

        mistakes, total_tests = word_test(question_words, answer_words, word_sequence)
        t.xp = c.course_length * c.REPETITION
        t.accuracy = round(t.xp / total_tests, digits=3)
        t.learn_time = t.xp * 5

        write_to_file(t, courses, "progress")
        write_to_file(t, mistakes, "mistakes")
end


function print_course(course_indices)
        println("-" ^ 15)
        for i in course_indices
                printstyled("Course $(i): Words $(1+(i-1)*25)-$(i * 25)\n", color=:magenta)
        end
        println("-" ^ 15)
end

main()