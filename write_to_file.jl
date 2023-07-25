function write_to_file(t, store, type)
    date = (time() |> unix2datetime |> string)[1:10]
    infile = open("out/$(type).tsv", "a")
    if type == "mistakes"
        println(infile, "$(date)\t$(join(store, ','))")
    else
        println(infile, "$(date)\t$(join(store, ','))\t$(t.accuracy)\t$(t.xp)\t$(t.learn_time)\t$(t.source)")
    end
    close(infile)
end