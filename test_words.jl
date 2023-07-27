function word_test(known, target, word_sequence)
        current = 1
        mistakes::Dict{String, Dict{String, Any}} = Dict()
    
        while current != length(word_sequence) + 1
            println("$(known[word_sequence[current]]) $(current)/$(length(word_sequence))")
            answer = strip(readline())
            word = target[word_sequence[current]]
    
            if answer != word
                push!(word_sequence, word_sequence[current])
    
                if haskey(mistakes, word)
                    word_data = mistakes[word]
                    word_data["count"] += 1
                    push!(word_data["answers"], answer)
                else
                    word_data = Dict("count" => 1, "answers" => [answer])
                    mistakes[word] = word_data
                end
    
                printstyled("$(target[word_sequence[current]]) ❌\n", color=:red)
            else
                printstyled("$(target[word_sequence[current]]) ✔️\n", color=:green)
            end
    
            println("-" ^ 15)
            current += 1
        end
    
        println("All mistakes:")
        for (word, word_data) in mistakes
            count = word_data["count"]
            answers = word_data["answers"]
            # Convert SubString{String} elements to regular strings
            formatted_answers = string.(answers)
            println("[$count, $word, $formatted_answers]")
        end
    
        return mistakes, current  
    end
    