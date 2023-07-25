using Random
using Dates

function write_mistakes(mistakes)
        #=
        Writes the mistakes made in the test to a file
        in:
                the made mistakes in sequence
        out:
                a file with all the mistakes in a TSV-file
        =#
        date = (time() |> unix2datetime |> string)[1:10]
        infile = open("out/mistakes.tsv", "a")
        println(infile, "$(date)\t$(join(mistakes, ','))")
        close(infile)
end

function write_results(courses, xp, accuracy, learn_time, source)
        #=
        Writes the results of the text file to out/progress
        in:
                the courses that were completed
                the xp that is granted to the user
                the accruracy of which the test was completed
                the learn calculated learn time for the user
                the file were the words came from
        out:
                a tsv file containing in the information that is put in
                including the date on which the test was taken on
        =#
        date = (time() |> unix2datetime |> string)[1:10]
        infile = open("out/progress.tsv", "a")
        println(infile, "$(date)\t$(join(courses, ','))\t$(accuracy)\t$(xp)\t$(learn_time)\t$(source)")
        close(infile)
end

function word_test(known, target, word_sequence)
        #=
        Test all the words in the course that the user does not know yet
        in:
                the known words
                the target language to learn
                the (random) sequence of the words to learn
        out:
                all the mistakes that were made in sequence
                the total length that the test took (begin + length(mistakes))
        =#
        current = 1
        mistakes::Vector{String} = []
        while current != length(word_sequence) + 1
                println("$(known[word_sequence[current]]) $(current)/$(length(word_sequence))")
                answer = strip(readline())
                if answer != target[word_sequence[current]]
                        push!(word_sequence, word_sequence[current])
                        push!(mistakes, target[word_sequence[current]])
                        printstyled("$(target[word_sequence[current]]) ❌\n", color=:red)
                else   
                        printstyled("$(target[word_sequence[current]]) ✔️\n", color=:green)
                end
                println("-" ^ 15)
                current += 1
        end
        printstyled("All mistakes:\n$(Set(mistakes))\n", color=:red)
        return mistakes, current  
end

function print_course(course_indices)
        #=
        Prints the courses that the user will be tested on with
                a nice purple color
        in:
                the indices of the courses
        out:
                nothing
        =#
        println("-" ^ 15)
        for i in course_indices
                printstyled("Course $(i): Words $(1+(i-1)*25)-$(i * 25)\n", color=:magenta)
        end
        println("-" ^ 15)
end

function choose_random_course(course::Vector{Vector{String}}, count)
        #=
        Chooses <count> random courses out of the courses 2D Vector
        in:
                a 2D Vector containing all the words in the courses
                the count of the random courses to be chosen
        out:
                all the courses with their words to be tested
        =#
        course_numbers = [i for i in eachindex(course)]
        testing_courses = sort(shuffle(course_numbers)[1:count])
        return testing_courses
end

function open_courses(filename::String)
        #=
        Opens the newline delimited data file
        in:
                a filename
        out:
                A 2D list containing all words per course delimited by newlines
        =#
        infile = open(filename)
        items = [[]]
        for i in eachline(infile)
                if i == ""
                        push!(items, [])
                else
                        push!(items[end], i)
                end
        end
        close(infile)
        return items
end


function main()
        course_count::Int = 2
        course_length::Int = 0
        REPETITION::Int = 2
        source::String = "Pinhok"
        nederlands::Vector{Vector{String}} = open_courses("words/$(source)/nederlands.txt")
        svenska::Vector{Vector{String}} = open_courses("words/$(source)/svenska.txt")


        println("Choose a course, or have 2 random courses\n" *
                "The courses should be separated by ;")
        
        ans = readline()
        courses = split(ans, ';')
        if all([all(isdigit, i) for i in courses]) &&
                all(i -> i <= length(nederlands), [parse(Int, i) for i in courses])
                course_indices = [parse(Int, i) for i in courses]
                course_count = length(course_indices)
                course_length = sum([length(nederlands[i]) for i in course_indices])
        else
                course_indices = choose_random_course(nederlands, course_count)
                course_length = sum([length(nederlands[i]) for i in course_indices])
        end
        word_sequence = shuffle([i for i in 1:(course_length)
                                   for _ in 1:REPETITION])
        dutch_words = reduce(vcat, [nederlands[i] for i in course_indices])
        swedish_words = reduce(vcat, [svenska[i] for i in course_indices])
        print_course(course_indices)
        mistakes, total_tests = word_test(dutch_words, swedish_words, word_sequence)
        xp = course_length * REPETITION
        accuracy = round(xp / total_tests, digits=3)
        learn_time = xp * 5
        write_results(courses, xp, accuracy, learn_time, source)
        write_mistakes(mistakes)
end

main()