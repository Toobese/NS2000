function open_courses(filename::String, courses::Vector{String})
    infile = open(filename)
    items = Vector{Vector{String}}()
    inside_section = false

    for line in eachline(infile)
        line = strip(line)
        if isempty(line)
            inside_section = false
        elseif inside_section
            push!(items[end], line)
        elseif all(isdigit, line) && line in courses
            inside_section = true
            push!(items, [])
        elseif all(isdigit, line)
            inside_section = false
        else
            inside_section = false
        end
    end
    close(infile)
    return items
end