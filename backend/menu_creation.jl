using REPL.TerminalMenus
include("open_courses.jl")

function colored_string(text::String, color_code::Int)
    return "\u001b[38;5;$(color_code)m$text\u001b[0m"
end

function option_menu(options, c)
    sources = RadioMenu(options)
    ans = request("Pick the source for the courses:, ", sources)
    c.course_name = options[ans]
end

function multiple_options_menu(options)
    sources = MultiSelectMenu(options)
    ans = request("Choose out of the following options (Multiple are possible): ", sources)
    return sort([i for i in ans])
end

function create_menu(c)
    source_options = readdir("words/")
    option_menu(source_options, c)
    known::Vector{Vector{String}} = open_courses("words/$(c.course_name)/question.txt")
    target::Vector{Vector{String}} = open_courses("words/$(c.course_name)/answer.txt")
    progress::Vector{String} = [line for line in eachline(open("words/$(c.course_name)/progress.tsv"))]

    println("Choose a course")
    course_names = Vector{String}()
    for color in enumerate(progress)
        colored_option = colored_string("Course $(color[1])", parse(Int, color[2]))
        push!(course_names, colored_option)
    end
    c.course_indices = multiple_options_menu(course_names)
    c.course_length = sum([length(known[i]) for i in c.course_indices])
    c.words = shuffle([i for i in 1:(c.course_length) for _ in 1:c.repetition])
    c.questions = reduce(vcat, [known[i] for i in c.course_indices])
    c.answers = reduce(vcat, [target[i] for i in c.course_indices])
end