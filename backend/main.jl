using Random
using Dates
include("storage.jl")
include("write_to_file.jl")
include("test_words.jl")
include("menu_creation.jl")

function main()
        c = course()
        t = test_result()
        td = test_data()

        println("indicate the amount of times a word needs to be repeated:")
        c.repetition = parse(Int, readline())

        create_menu(c)
        word_test(c, td)
        t.xp = c.course_length * c.repetition
        t.accuracy = round(t.xp / length(c.words), digits=3)
        t.learn_time = t.xp * 5

        write_to_file(t, td, c)
        update_progress(c, t)
end

main()