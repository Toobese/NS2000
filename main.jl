using Random
using Dates
include("storage.jl")
include("languages.jl")
include("write_to_file.jl")
include("test_words.jl")
include("menu_creation.jl")

function main()
        c = course()
        t = test_result()
        println("indicate the amount of times a word needs to be repeated:")
        c.repetition = parse(Int, readline())

        language = show_selection_menu("language", c)
        courses = show_selection_menu("course(s)", c)
        question_lan = get_language(language[1], courses)
        answer_lan = get_language(language[2], courses)

        c.course_length = sum([length(words) for words in question_lan.words])

        word_sequence = shuffle([i for i in 1:(c.course_length) for _ in 1:c.repetition])
        question_words = reduce(vcat, [questions for questions in question_lan.words])
        answer_words = reduce(vcat, [answers for answers in answer_lan.words])

        mistakes, total_tests = word_test(question_words, answer_words, word_sequence)
        t.xp = c.course_length * c.repetition
        t.accuracy = round(t.xp / total_tests, digits=3)
        t.learn_time = t.xp * 5

        write_to_file(t, courses, "progress")
        tot_mistakes = write_to_file(t, mistakes, "mistakes")
        if length(courses) == 1
                update_progress(tot_mistakes/(tot_mistakes + c.course_length), courses[1], c)
        end
end

function update_progress(mistake_ratio, course, c)
        (tmppath, tmpio) = mktemp()
        infile = open("$(c.chosen_path)/progress.tsv")
        i = 1
        for line in eachline(infile, keep=true)
                if "$(i)" == course
                        if mistake_ratio >= 0.3
                                line = "1"
                                println(tmpio, line)
                        elseif mistake_ratio > 0.0
                                line = "2"
                                println(tmpio, line)
                        elseif mistake_ratio == 0.0
                                line = "3"
                                println(tmpio, line)
                        end
                else
                        print(tmpio, line)
                end
                i += 1
        end
        close(tmpio)
        mv(tmppath, "$(c.chosen_path)/progress.tsv", force=true)
end    

function print_course(course_indices)
        println("-" ^ 15)
        for i in course_indices
                printstyled("Course $(i): Words $(1+(i-1)*25)-$(i * 25)\n", color=:magenta)
        end
        println("-" ^ 15)
end

main()