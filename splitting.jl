function reading(counter, group_number)
    infile = open("words/japanese/english.txt")
    outfile = open("words/japanese/test2.tsv", "a")
    println(outfile, group_number)
    group_number += 1
    for line in eachline(infile)
        if counter % 25 == 0
            println(outfile, "")
            println(outfile, group_number)
            group_number += 1
        else
            println(outfile, line)
        end
        counter += 1
    end
    close(outfile)
    close(infile)
end

reading(1, 1)