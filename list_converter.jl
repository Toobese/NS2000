# Function to convert a line from the given format to the desired format
function convert_line(line::AbstractString)
    parts = split(line, " - ")
    if length(parts) != 2
        return line  # Return the original line if the format is not as expected
    end
    kana_word = strip(parts[1])
    english_word = lowercase(strip(parts[2]))  # Convert to lowercase and remove capital letter
    
    return "$english_word"
end

# Specify input and output file paths
input_file_path = "words/jp_N5_vocabulary/english.txt"
output_file_path = "english.txt"

# Read lines from the input file, convert them, and write to the output file
function convert_file(input_file_path, output_file_path)
    open(output_file_path, "w") do output_file
        for line in eachline(input_file_path)
            converted_line = convert_line(line)
            println(output_file, converted_line)
        end
    end
end

# Call the function to convert the file
convert_file(input_file_path, output_file_path)