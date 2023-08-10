using REPL.TerminalMenus
include("open_courses.jl")

function option_menu(options)
    sources = RadioMenu(options)
    ans = request("Pick the source for the courses:, ", sources)
    return options[ans]
end

function multiple_options_menu(options)
    sources = MultiSelectMenu(options)
    ans = request("Choose out of the following options (Multiple are possible): ", sources)
    return sort([i for i in ans])
end

function create_menu(c)
    source_options = readdir("words/")
    source::String = option_menu(source_options)
    known::Vector{Vector{String}} = open_courses("words/$(source)/answer.txt")
    target::Vector{Vector{String}} = open_courses("words/$(source)/question.txt")

    println("Choose a course")
    course_names = ["Course $(i)" for i in eachindex(known)]
    c.course_indices = multiple_options_menu(course_names)
    c.course_length = sum([length(known[i]) for i in c.course_indices])
    c.words = shuffle([i for i in 1:(c.course_length) for _ in 1:c.repetition])
    c.questions = reduce(vcat, [known[i] for i in c.course_indices])
    c.answers = reduce(vcat, [target[i] for i in c.course_indices])
end