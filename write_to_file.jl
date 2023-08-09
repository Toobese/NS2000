function write_to_file(t, store, type)
    date = (time() |> unix2datetime |> string)[1:10]
    infile = open("out/$(type).tsv", "a")
    total_mistakes = 0
    if type == "mistakes"
        println(infile, "$(date)\t")
        for (word, word_data) in store
            count = word_data["count"]
            answers = word_data["answers"]
            formatted_answers = string.(answers)
            total_mistakes += count
            spaces = 30 - (5 + length(word))
            if spaces >= 0
                println(infile, "[$count | $word", " " ^spaces, "$formatted_answers]")
            else
                println(infile, "[$count | $word \t\t\t $formatted_answers]")
            end
        end
        println(total_mistakes)
        println(infile, "-" ^30)
    else
        println(infile, "| $(date) | \t $(t.accuracy) \t | \t $(t.xp) \t | \t $(t.learn_time) \t | \t $(join(store, ',')) \t |")
    end
    close(infile)
    return total_mistakes
end