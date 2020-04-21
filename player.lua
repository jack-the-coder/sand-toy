player = {}

function updatePlayer(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = 1}
    p.rA = math.random() * 0.4 + 0.7
    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    elseif (getNeighbor({x = d.x, y = 0}) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor({x = d.x, y = 0}, p)
    elseif (getNeighbor({x = -d.x, y = 0}) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor({x = -d.x, y = 0}, p)
    else
        setNeighbor({x = 0, y = 0}, p)
    end
end
