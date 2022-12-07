include("../aux.jl")

function main()
    file = "input.txt"
    starting_creates, commands_text = read(joinpath(@__DIR__, file), String) |> x -> split(x, "\n\n") |> x -> split.(x, "\n")

    num_crates = starting_creates[end] |> split |> x -> parse.(Int, x) |> last
    stacks_of_crates = [String[] for _ = 1:num_crates]

    parse_crate_line(x) = begin
        i = 1
        while i < length(x)
            y = if x[i:i+2] == "   "
                "."
            else
                x[i+1:i+1]
            end
            x = if i + 2 < length(x)
                x[1:i-1] * y * "," * x[i+4:end]
            else
                x[1:i-1] * y
            end
            i += 2
        end
        x
    end
    parsed_crate_lines = starting_creates[1:end-1] |>
        x -> parse_crate_line.(x) |>
        x -> split.(x, ",") |>
        reverse
    # @show parsed_crate_lines
    for line in parsed_crate_lines
        for (i, s) in enumerate(line)
            if s != "."
                push!(stacks_of_crates[i], s)
            end
        end
    end

    commands = map(filter(x -> length(x) > 0, commands_text)) do s
        parse.(Int, match(r"move ([0-9]*) from ([0-9]*) to ([0-9]*)", s).captures)
    end

    show_stacks(stacks) = begin
        for line in stacks
            println(join(line, "-"))
        end
        println("")
    end

    # show_stacks()
    stacks_of_crates1 = deepcopy(stacks_of_crates)
    for (number, from, to) in commands
        for _ = 1:number
            if length(stacks_of_crates1[from]) == 0
                break
            end
            push!(stacks_of_crates1[to], pop!(stacks_of_crates1[from]))
        end
        # println("Move $number from $from to $to")
        # show_stacks()
    end

    stacks_of_crates2 = deepcopy(stacks_of_crates)
    show_stacks(stacks_of_crates2)
    for (number, from, to) in commands
        stack_size = length(stacks_of_crates2[from])
        idx = max(1, stack_size-number+1):stack_size
        append!(stacks_of_crates2[to], splice!(stacks_of_crates2[from], idx))
        println("Move $number from $from to $to")
        show_stacks(stacks_of_crates2)
    end

    msg1 = map(stacks_of_crates1) do v
        v[end]
    end |> join
    msg2 = map(stacks_of_crates2) do v
        v[end]
    end |> join

    msg1, msg2
end

main()
