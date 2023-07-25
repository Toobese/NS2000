function word_test(known, target, word_sequence)
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