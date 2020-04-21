player = {}

player.xSpeed = 0
player.ySpeed = 0

wDown = false
aDown = false
sDown = false
dDown = false

counter = 0

function updatePlayer(p, getNeighbor, setNeighbor, dt)
	counter = counter + dt

    local d = {x = math.random(-1, 1), y = 1}
    local r = {x = math.random(0, 2), y = 0}
    local l = {x = math.random(-2, 0), y = 0}
    local u = {x = 0, y = -5}
    p.rA = math.random() * 0.2 + 0.7
    if (getNeighbor(d) == 0) then -- gravity
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    else
    	if (getNeighbor(r) == 0 and dDown) then
    		setNeighbor({x = 0, y = 0}, 0)
        	setNeighbor(r, p)
        	if math.floor(counter) % 5 == 0 then
        		dDown = false
        	end
        end
        if (getNeighbor(l) == 0 and aDown) then
    		setNeighbor({x = 0, y = 0}, 0)
        	setNeighbor(l, p)
        	if math.floor(counter) % 5 == 0 then
        		aDown = false
        	end
        end
        --if (getNeighbor(u) == 0 and wDown) then
    	--	setNeighbor({x = 0, y = 0}, 0)
        --	setNeighbor(u, p)
        --	if math.floor(counter) % 25 == 0 then
        --		wDown = false
        --	end
        --end
    end
    
end
