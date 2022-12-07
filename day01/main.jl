include("../aux.jl")

function main()
    file = "input.txt"
    calories = read(joinpath(@__DIR__, file), String) |>
        x -> split(x, "\n\n") .|>
        split .|>
        x -> Meta.parse.(x) |>
        sum
    most_calories = findmax(calories)
    @show most_calories

    top3 = sort(calories, rev=true)[1:3] |> sum
    @show top3
end

main()
