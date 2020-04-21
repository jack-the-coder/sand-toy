player = {}

wDown = false
aDown = false
sDown = false
dDown = false

function updatePlayer(p, getNeighbor, setNeighbor, dt)
    local d = {x = math.random(-1, 1), y = 1}
    local r = {x = math.random(0, 2), y = 0}
    local l = {x = math.random(-1, 0), y = 0}
    local u = {x = math.random(-1, 1), y = -1}
    p.rA = math.random() * 0.2 + 0.7
    if (getNeighbor(d) == 0) then -- gravity
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    else
    	-- uncomment this for liquid-like shininess
    	-- setNeighbor({x = 0, y = 0}, p)
    end
    if wDown then
    	if (getNeighbor(u) == 0 or getNeighbor(u) == 7) then
    		setNeighbor({x = 0, y = 0}, 0)
    		setNeighbor(u, p)
    	end
    	if math.clamp(dt, 0, 10) % 2 == 0 then
    		wDown = false
    	end
    end
    if aDown then
    	if (getNeighbor(l) == 0 or getNeighbor(l) == 7) then
    		setNeighbor({x = 0, y = 0}, 0)
    		setNeighbor(l, p)
    	end
    	if math.clamp(dt, 0, 10) % 2 == 0 then
    		aDown = false
    	end
    end
    if dDown then
    	if (getNeighbor(r) == 0 or getNeighbor(r) == 7) then
    		setNeighbor({x = 0, y = 0}, 0)
    		setNeighbor(r, p)
    	end
    	if math.clamp(dt, 0, 10) % 2 == 0 then
    		dDown = false
    	end
    end

end
