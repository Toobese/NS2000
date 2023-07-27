function show_selection_menu(options::Vector{String}, print_message::String, c)
    println("Select the $(print_message) you want to do:")
    selected_categories = Vector{String}()
    generate_menu(options)

    println("[0] Done selecting")

    while true
        choice = readline()
        selected_index = parse(Int, choice)

        if selected_index == 0
            break
        elseif 1 <= selected_index <= length(options)
            if print_message == "language"
                return c.language_names[selected_index]
            else
                push!(selected_categories, options[selected_index])
            end
        else
            println("Invalid choice. Please enter a valid number.")
        end
    end
    return selected_categories
end

function generate_menu(options::Vector{String})
    num_rows = 5

    for i in 1:num_rows
        j = i
        while j <= length(options)
            print("[$j] $(options[j])", "\t\t")
            j += 5
        end
        println()
    end
end