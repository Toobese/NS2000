using Random
using Dates
include("storage.jl")
include("write_to_file.jl")
include("test_words.jl")
include("menu_creation.jl")

function main()
        c = course()
        t = test_result()

        println("indicate the amount of times a word needs to be repeated:")
        c.repetition = parse(Int, readline())

        create_menu(c)
        mistakes, total_tests = word_test(c.questions, c.answers, c.words)
        t.xp = c.course_length * c.repetition
        t.accuracy = round(t.xp / total_tests, digits=3)
        t.learn_time = t.xp * 5

        tot_mistakes = write_to_file(t, mistakes, "mistakes")
end

main()