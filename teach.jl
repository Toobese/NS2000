using Random

function word_test(known, target, word_sequence)
        current = 1
        mistakes = []
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
        
end

function print_course(course_indices)
        println("-" ^ 15)
        for i in course_indices
                printstyled("Course $(i): Words $(1+(i-1)*25)-$(i * 25)\n", color=:magenta)
        end
        println("-" ^ 15)
end

function choose_random_course(course::Vector{Vector{String}}, count)
        course_numbers = [i for i in eachindex(course)]
        testing_courses = sort(shuffle(course_numbers)[1:count])
        return testing_courses
end

function open_courses(filename::String)
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
        course_count = 2
        course_length = 25
        repetition = 2
        nederlands::Vector{Vector{String}} = open_courses("words/nederlands.txt")
        svenska::Vector{Vector{String}} = open_courses("words/svenska.txt")


        println("Choose a course, or have 2 random courses\n" *
                "The courses should be separated by whitespace")
        
        ans = readline()
        courses = split(ans, ';')
        if all([all(isdigit, i) for i in courses]) &&
                all(i -> i <= length(nederlands), [parse(Int, i) for i in courses])
                course_indices = [parse(Int, i) for i in courses]
        else
                course_indices = choose_random_course(nederlands, course_count)
        end
        word_sequence = shuffle([i for i in 1:(2 * course_length)
                                   for _ in 1:repetition])
        dutch_words = reduce(vcat, [nederlands[i] for i in course_indices])
        swedish_words = reduce(vcat, [svenska[i] for i in course_indices])
        print_course(course_indices)
        word_test(dutch_words, swedish_words, word_sequence)

end

main()