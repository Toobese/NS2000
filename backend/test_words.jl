function revert_mistake(c, td)
    last_mistake_index = td.last_mistake_indices[end]
    word_to_correct = c.answers[c.words[last_mistake_index]]
    word_data = td.mistakes[word_to_correct]

    if word_data["count"] == 1
        delete!(td.mistakes, word_to_correct)
    else
        word_data["count"] -= 1
        pop!(word_data["answers"])
    end

    pop!(c.words)

    println("Last mistake reverted.")
    println("-" ^ 15)
    pop!(td.last_mistake_indices)
end

function wrong_answer(c, td, correct_word, answer, word)
    push!(c.words, word[2])

    if haskey(td.mistakes, correct_word)
        word_data = td.mistakes[correct_word]
        word_data["count"] += 1
        push!(word_data["answers"], answer)
    else
        word_data = Dict("count" => 1, "answers" => [answer])
        td.mistakes[correct_word] = word_data
    end

    push!(td.last_mistake_indices, word[1])
    printstyled("$(c.answers[word[2]]) ❌\n", color=:red)
end

function word_test(c, td)
    for word in enumerate(c.words)
        println("$(c.questions[word[2]]) $(word[1])/$(length(c.words))")
        correct_word = c.answers[word[2]]
        answer = readline()
        
        if answer == "=" && length(td.last_mistake_indices) >= 2
            revert_mistake(c, td)
            println("$(c.questions[word[2]]) $(word[1])/$(length(c.words))")
            answer = readline()
        end

        if answer != correct_word
            wrong_answer(c, td, correct_word, answer, word)
        else
            printstyled("$(c.answers[word[2]]) ✔️\n", color=:green)
        end
        println("-" ^ 15)
    end
end