player = {}

player.xSpeed = 0
player.ySpeed = 0

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
    
end
