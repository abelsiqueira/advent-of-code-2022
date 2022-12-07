include("../aux.jl")

function priority(c :: Char)
    if c in 'a':'z'
        return (c - 'a') + 1
    else
        return (c - 'A') + 27
    end
end

function main()
    file = "input.txt"
    rucksacks = readlines(joinpath(@__DIR__, file))
    rucksacks_split = [
        begin
            n = div(length(x), 2)
            Set.([x[1:n], x[n+1:end]])
        end for x in rucksacks
    ]

    intersection_sets = [
        left ∩ right
        for (left, right) in rucksacks_split
    ]
    intersections = only.(intersection_sets)

    @show sum(priority.(intersections))

    @show typeof(rucksacks[1])
    intersection_triplets = [
        ∩(Set.(rucksacks[i:i+2])...)
        for i = 1:3:length(rucksacks)
    ] .|> only
    @show sum(priority.(intersection_triplets))
end

main()
