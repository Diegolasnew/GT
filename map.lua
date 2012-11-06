local map = {}

map.tile = {}
map.typTile = {}
map.size = 50
map.w = 50
map.h = 20
map.tex = love.graphics.newImage('gfx/tile.png')
map.starX = 200
map.startY = 200
map.batch = nil

function map:init()
	--map.tex = love.graphics.newImage('gfx/tile.png')
	map.batch = gfx.newSpriteBatch(map.tex, map.w * map.h)
	local pos = 1
	for i = 0, map.tex:getHeight()/map.size -1 do 
		for j = 0, map.tex:getWidth()/map.size -1 do
			map.typTile[pos] = gfx.newQuad(j*map.size, i*map.size, map.size, map.size, map.tex:getWidth(), map.tex:getHeight())
			pos = pos + 1
		end

	end

	for i = 0, map.w do
		map.tile[i]={}
		for j = 0, map.h do
			map.tile[i][j] = 0
		end
	end

	map.tile[1][1] = 1
end

function map:update()
	map.batch:bind()
    map.batch:clear()
    for x = 0, map.w do
        for y = 0, map.h do
            tile = map.tile[x][y]
            if tile ~=0 then
                map.batch:addq(map.typTile[tile], (x)*map.size, (y)*map.size)
            end
        end
    end
    map.batch:unbind()
end

function map:loadTypTile()
end

function map:draw(  )
	gfx.draw(map.batch, 0, 0)
end

return map