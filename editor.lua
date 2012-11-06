
function initEditor(  )
	batchEditor = gfx.newSpriteBatch(mapa.tex, 100)
	posObjetoEditor = 0
	ponerObjeto = false
	eliminarObjeto = false
end


function guardarMapa(  )
	cont = ""
	for k, v in pairs(mapa.objetos) do
		cont = cont .. v.tipo .. " " .. v.cuadColi.x .. " " ..v.cuadColi.y .. " " .. v.cuadColi.w .. " " .. v.cuadColi.h .. "/"
	end
	fsy.write("map.mep", cont)
end

function cargarMapa( nombreMapa )
	local data = fsy.read(nombreMapa ..".mep")
	local split = data:split("/")
	for i, v in pairs(split) do
		split2 = v:split(" ")
		if (i ~= table.getn(split)) then
			local o1 = new("objeto")
			o1:init(tonumber(split2[2]), tonumber(split2[3]), tonumber(split2[4]), tonumber(split2[5]), tonumber(split2[1]), mapa.tipoTex[tonumber(split2[1])])
			mapa:ubicarObjeto(o1)
		end
	end
end


function updateEditor()
	local x, y = love.mouse.getPosition()
	x = x - translate[1]
	y = y - translate[2]
	if (posObjetoEditor > table.getn(mapa.tipoTex)) then
		posObjetoEditor = 0
	end
	if (posObjetoEditor < 0) then
		posObjetoEditor = table.getn(mapa.tipoTex)
	end
	batchEditor:bind()
	batchEditor:clear()
	if (posObjetoEditor ~= 0) then
		local x1, y1, w, h = mapa.tipoTex[posObjetoEditor]:getViewport()		
		x = math.floor(x - (w/2))
		y = math.floor(y - (h/2))
		batchEditor:setColor(255,255,255,200)
		batchEditor:addq(mapa.tipoTex[posObjetoEditor], x, y)
		if ponerObjeto then
			local o1 = new("objeto")
			print(h)
			o1:init(x, y, w, h, posObjetoEditor, mapa.tipoTex[posObjetoEditor])
			mapa:ubicarObjeto(o1)
			ponerObjeto = false
		end
	else
		ponerObjeto = false

		if eliminarObjeto then
			mapa:eliminarObjeto(x, y)
		end
		eliminarObjeto = false
	end
	batchEditor:unbind()
	
end

function drawEditor(  )
	gfx.draw(batchEditor, 0, 0)
end