include("../aux.jl")

function main()
    file = "input.txt"
    ϕ(adashb) = begin
        a, b = split(adashb, "-") .|> Meta.parse
        return a:b
    end
    configurations = readlines(joinpath(@__DIR__, file))
    conf_ranges = configurations .|>
        x -> split(x, ",") |>
        x -> ϕ.(x)
    map(conf_ranges) do x
        (x[1] ⊆ x[2] || x[2] ⊆ x[1]), length(x[1] ∩ x[2]) > 0
    end |>
        x -> (sum(getindex.(x, 1)), sum(getindex.(x, 2)))
end

main()
