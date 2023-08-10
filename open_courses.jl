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