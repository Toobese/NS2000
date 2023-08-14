function convert_line(line::AbstractString)
    parts = split(line, " - ")
    if length(parts) != 2
        return line
    end
    kana_word = strip(parts[1])
    english_word = lowercase(strip(parts[2]))
    
    return "$english_word"
end

input_file_path = "words/jp_N5_vocabulary/english.txt"
output_file_path = "english.txt"

function convert_file(input_file_path, output_file_path)
    open(output_file_path, "w") do output_file
        for line in eachline(input_file_path)
            converted_line = convert_line(line)
            println(output_file, converted_line)
        end
    end
end

convert_file(input_file_path, output_file_path)