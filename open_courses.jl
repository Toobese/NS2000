function open_courses(filename::String, courses::Vector{String})
    infile = open(filename)
    items = Vector{Vector{String}}()
    inside_section = false

    for line in eachline(infile)
        line = strip(line)
        if isempty(line)
            inside_section = false
        else
            parts = split(line, "-", limit=2)
            if length(parts) == 2
                course_number, category = strip(parts[1]), strip(parts[2])
                if !isempty(course_number) && all(isdigit, course_number) && category in courses
                    inside_section = true
                    push!(items, [])
                else
                    inside_section = false
                end
            elseif inside_section
                push!(items[end], line)
            end
        end
    end
    close(infile)
    return items
end