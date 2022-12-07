include("../aux.jl")

function score_game(strategy :: Vector{Char})
    opponent, me = strategy[1] - 'A', strategy[2] - 'X'
    win = mod(opponent - me, 3) == 2
    lose = mod(me - opponent, 3) == 2
    return 3 + 3win - 3lose + (me + 1)
end

function score_game_alt(strategy :: Vector{Char})
    opponent = strategy[1] - 'A'
    result = strategy[2] - 'X' - 1
    me = mod(opponent + result, 3)
    win, lose = result == 1, result == -1

    return 3 + 3win - 3lose + (me + 1)
end

function main()
    file = "input.txt"
    strategies = readlines(joinpath(@__DIR__, file)) .|>
        x -> split(x, " ") .|>
        x -> getindex.(x, 1) # Transform to Char


    scores = score_game.(strategies)
    @show scores |> sum

    real_scores = score_game_alt.(strategies)
    @show real_scores |> sum

    # clean_scores = real_scores - (getindex.(strategies, 2) .- 'X' .+ 1)
    # [strategies real_scores]
end

main()
