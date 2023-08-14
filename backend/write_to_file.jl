function write_to_file(t, td, c)
    date = (time() |> unix2datetime |> string)[1:10]
    mistakes_file, progress_file = open("out/mistakes.tsv", "a"), open("out/progress.tsv", "a")
    println(mistakes_file, "$(date)\t")
    for (word, word_data) in td.mistakes
        println(mistakes_file, "[$(word_data["count"]) | $word", " " ^(60 - (5 + length(word))), "$(string.(word_data["answers"]))]")
        println("[$(word_data["count"]) | $word", " " ^(60 - (5 + length(word))), "$(string.(word_data["answers"]))]")
    end
    if !isempty(td.mistakes)
        println("total mistakes: $(sum(word_data["count"] for (word, word_data) in td.mistakes))")
    else
        println("FLAWLESS")
    end
    println(mistakes_file, "-" ^30)
    println(progress_file, "| $(date) | \t $(t.accuracy) \t | \t $(t.xp) \t | \t $(t.learn_time) \t | \t $(join(c.course_indices, ',')) \t |")
    close(mistakes_file)
    close(progress_file)
end

function update_progress(c, t)
    (tmppath, tmpio) = mktemp()
    infile = open("words/$(c.course_name)/progress.tsv")
    counter = 1
    for line in eachline(infile)
        if counter in c.course_indices
            if t.accuracy <= 0.5
                line = "196"
            elseif t.accuracy <= 0.8
                line = "166"
            elseif t.accuracy < 1.0
                line = "2"
            elseif t.accuracy == 1.0
                line = "154"
            end
        end
        counter += 1
        println(tmpio, line)
    end
    close(tmpio)
    mv(tmppath, "words/$(c.course_name)/progress.tsv", force=true)
end    
