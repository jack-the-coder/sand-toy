function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function add(a, b)
	return {x = a.x + b.x, y = a.y + b.y}
end

function math.clamp(val, lower, upper)
	assert(val and lower and upper, "math.clamp called with too few args")
	if lower > upper then
		lower, upper = upper, lower
	end -- swap if boundaries supplied the wrong way
	return math.max(lower, math.min(upper, val))
end

-- play field width in pixels * cellSize
-- also the default window size
width = 1067
height = 600

screenWidth, screenHeight = love.graphics.getDimensions()


cellSize = 6
widthCells = math.floor(width / cellSize)
heightCells = math.floor(height / cellSize)
cells = {} -- create the matrix

chunks = {}

function isValidPos(pos)
	if ((pos.x < widthCells) and (pos.y < heightCells)) then
		if ((pos.x > 0) and (pos.y > 0)) then
			return true
		end
	end
	return false
end

function makeParticle(pos, type)
	local p = {
		type = type,
		rA = 0.5 + math.random() * 0.1,
		rB = 0
	}
	if (isValidPos(pos)) then
		if (cells[pos.x][pos.y] == 0) then
			cells[pos.x][pos.y] = p
		end
	end
end

function neighborGetter(pos)
	return function(offset)
		local oX = math.clamp(offset.x, -1, 1)
		local oY = math.clamp(offset.y, -1, 1)
		local rX = pos.x + oX
		local rY = pos.y + oY
		if (rX < 1 or rX >= widthCells + 1 or rY < 1 or rY >= heightCells) then
			return nil
		end
		return cells[rX][rY]
	end
end

function neighborSetter(pos)
	return function(offset, v)
		local oX = math.clamp(offset.x, -1, 1)
		local oY = math.clamp(offset.y, -1, 1)
		local rX = pos.x + oX
		local rY = pos.y + oY
		if (rX < 1 or rX >= widthCells + 1 or rY < 1 or rY >= heightCells) then
			print("oob set")
			return nil
		end

		cells[rX][rY] = v
		if (v ~= 0) then
			imageData:setPixel(rX - 1, rY - 1, v.type / 10., v.rA, v.rB, 1)
		else
			imageData:setPixel(rX - 1, rY - 1, 0, 0, 0, 1)
		end
	end
end

for i = 1, widthCells do
	cells[i] = {} -- create a new row
	for j = 1, heightCells do
		cells[i][j] = 0
		-- makeParticle({x = i, y = j})
	end
end

--for i = 0, 100 do
--	local pos = {
--		x = math.random(1, widthCells),
--		y = math.random(1, heightCells - 1)
--	}
--	makeParticle(pos, 1)
--end
