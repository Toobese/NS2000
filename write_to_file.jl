function write_to_file(t, type)
    date = (time() |> unix2datetime |> string)[1:10]
    infile = open("out/$(type).tsv", "a")
    if type == "mistakes"
        println(infile, "$(date)\t$(join(t.mistakes, ','))")
    else
        print(infile, "$(date)\t$(join(t.courses, ','))\t$(t.accuracy)\t$(t.xp)\t$(t.learn_time)\t$(t.source)")
    end
    close(infile)
end