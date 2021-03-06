function updateCell(p, getNeighbor, setNeighbor, dt)
    if (p.type == 1) then
        return updateDust(p, getNeighbor, setNeighbor)
    elseif (p.type == 2) then
        return updateWater(p, getNeighbor, setNeighbor)
    elseif (p.type == 3) then
        return updateGas(p, getNeighbor, setNeighbor)
    elseif (p.type == 4) then
        return updateWall(p, getNeighbor, setNeighbor)
    elseif (p.type == 5) then
        return updateOil(p, getNeighbor, setNeighbor)
    elseif (p.type == 6) then
        return updateFire(p, getNeighbor, setNeighbor, dt)
    elseif (p.type == 7) then
        return updatePlayer(p, getNeighbor, setNeighbor, dt)
    elseif (p.type == 8) then
        return updateClone(p, getNeighbor, setNeighbor)
    elseif (p.type == 9) then
        return updateLife(p, getNeighbor, setNeighbor)
    else
        -- using wall because otherwise it creates 
        -- black things that you can't remove
        return updateWall(p, getNeighbor, setNeighbor)
        -- commented out because this appears to decrease framerate
        -- print("unknown type")
    end
end

function updateWall(p, getNeighbor, setNeighbor)
    setNeighbor({x = 0, y = 0}, p)
end

function updateGas(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = math.random(-1, 1)}
    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    end
end

function updateWater(p, getNeighbor, setNeighbor)
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

function updateDust(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = 1}
    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    end
end

function updateClone(p, getNeighbor, setNeighbor)
    local d = {x = 0, y = 0}
    for x = -1, 1 do
        for y = -1, 1 do
            local nbr = getNeighbor({x = x, y = y})

            if (p.rB == 0) then
                if (nbr ~= 0 and nbr.type ~= 8 and p.rB == 0) then
                    p.rB = nbr.type
                    p.rA = 1.0
                    return
                end
            else
                if (nbr == 0) then
                    setNeighbor({x = x, y = y}, {type = p.rB, rA = 0.5, rB = 0})
                    break
                end
            end
        end
    end
    setNeighbor({x = 0, y = 0}, p)
end

function updateOil(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = 1}
    p.rA = math.random() * 0.4 + 0.3
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

function updateFire(p, getNeighbor, setNeighbor, dt)
    local d = {x = math.random(-1, 1), y = math.random(-1, 0)}
    local down = {x = math.random(-1, 1), y = 3}

    counter = counter + dt

    for x = -1, 1 do
        for y = -1, 1 do
            local nbr = getNeighbor({x = x, y = y})
            if (nbr == 0 or nbr == nil) then
                -- continue;
            elseif nbr.type == 3 then
                setNeighbor({x = x, y = y}, {type = 6, rA = 1.0, rB = 0})
                return
            elseif nbr.type == 5 then
                setNeighbor({x = x, y = y-2}, {type = 6, rA = 1.0, rB = 0})
                if math.floor(math.random(0, 2)) then
                    if getNeighbor(down) ~= 0 and getNeighbor(down) ~= nil and getNeighbor(down).type == 5 then
                        setNeighbor(down, 0)
                    end
                end
            elseif nbr.type == 2 then
                p.rA = 0
            end
        end
    end
    p.rA = p.rA - 0.01

    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        if (p.rA > 0) then
            setNeighbor(d, p)
        end
    end
end

function updateLife(p, getNeighbor, setNeighbor)
    local d = {x = 0, y = 0}
    local isAlive = p.rA > 0.5

    local n = -1
    for x = -1, 1 do
        for y = -1, 1 do
            local nbr = getNeighbor({x = x, y = y})
            if (nbr ~= 0 and nbr.type == 5 and nbr.rA > 0.5) then
                n = n + 1
            end
        end
    end
    if (isAlive == false) then
        if (n == 3 or math.random(100) < 1) then
            isAlive = true
        end
    else
        if (n < 2) then
            isAlive = false
        elseif (n < 4) then
            isAlive = true
        else
            isAlive = false
        end
    end
    p.rA = isAlive and 0.9 or 0.1
    setNeighbor({x = 0, y = 0}, p)

    -- if (getNeighbor(d) == 0) then
    -- setNeighbor({x = 0, y = 0}, 0)
    -- setNeighbor(d, p)
    -- end
end
