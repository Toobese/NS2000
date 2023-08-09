function show_selection_menu(print_message::String, c)
    println("Select the $(print_message) you want to do:")
    selected_categories = Vector{String}()
    loop_amount = generate_menu(c, print_message)

    println("[0] Done selecting")

    while true
        choice = readline()
        selected_range = split(choice, "-", limit=2)

        if length(selected_range) == 2 && print_message == "course(s)"
            left, right = selected_range
            left = parse(Int, left)
            right = parse(Int, right)
            while left <= right
                push!(selected_categories, left)
                left += 1
            end
        else
            selected_index = parse(Int, choice)
            if selected_index == 0
                break
            elseif 1 <= selected_index <= loop_amount
                if print_message == "language"
                    c.chosen_path = "words/$(c.language_names[selected_index][3])"
                    return c.language_names[selected_index]
                else
                    push!(selected_categories, "$(selected_index)")
                end
            else
                println("Invalid choice. Please enter a valid number.")
            end
        end
    end
    return selected_categories
end

function generate_menu(c, print_message)
    if print_message != "language"
        c.progress_score, loop_amount = get_progress(c)
    else
        loop_amount = length(c.languages)
    end
    num_rows = 6
    println(loop_amount)

    for i in 1:num_rows
        j = i
        while j <= loop_amount
            if print_message == "language"
                print("[$j] $(c.languages[j])", "\t")
            elseif c.progress_score[j] == "0"
                print("[$j] $(j)", "\t")
            elseif c.progress_score[j] == "1"
                printstyled("[$j] $(j)", "\t", color=:red)
            elseif c.progress_score[j] == "2"
                printstyled("[$j] $(j)", "\t", color=:yellow)
            elseif c.progress_score[j] == "3"
                printstyled("[$j] $(j)", "\t", color=:green)
            end
            j += 6
        end
        println()
    end
    return loop_amount
end

function get_progress(c)
    infile = open("$(c.chosen_path)/progress.tsv")
    println("$(c.chosen_path)/progress.tsv")
    progress = Vector{String}()
    loop_amount = 0
    for line in eachline(infile)
        loop_amount += 1
        push!(progress, line)
    end
    return progress, loop_amount
end