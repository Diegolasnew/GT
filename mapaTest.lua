-- mapa de prueba

mapa = {}

mapa.xVisible = 0
mapa.yVisible = 0
mapa.matrizObjetos = {} --todas las entidades puestas en una matriz para ver si colisionan con algo

mapa.objetos = {} --objetos en general, no movibles 
mapa.movibles = {} --todos los objetos movibles
mapa.enemigos = {} -- todos los enemigos del mapa
mapa.jugadores = {} -- todos los jugadores en el mapa

mapa.sizeCelda = 100
mapa.ancho = 70
mapa.alto = 70
mapa.tex = gfx.newImage('gfx/gen.png')
mapa.tipoTex = {}
mapa.propTex = {}
mapa.batch = nil


function mapa:init()

	for i=0, mapa.ancho do
			mapa.matrizObjetos[i]={}
			for j=0, mapa.alto do
				mapa.matrizObjetos[i][j] = {}
			end
	end	

	for i=0, mapa.ancho do
			mapa.objetos[i]={}
			for j=0, mapa.alto do
				mapa.objetos[i][j] = {}
			end
	end	

	local data = fsy.read("gfx/genProp.txt")
	local split = data:split("/")
	for i, v in pairs(split) do
		split2 = v:split(" ")
		if (i ~= table.getn(split)) then
			mapa.tipoTex[i] = gfx.newQuad(split2[1], split2[2], split2[3], split2[4], mapa.tex:getWidth(), mapa.tex:getHeight())
			mapa.propTex[i] = {}
			mapa.propTex[i].desX = split2[5]
			mapa.propTex[i].desY = split2[6]
			mapa.propTex[i].w = split2[7]
			mapa.propTex[i].h = split2[8]

		end
	end

	mapa.batch = gfx.newSpriteBatch(mapa.tex, 300)

end

function mapa:ubicarObjeto(objeto)
	for i=math.floor(objeto.cuadColi.x/mapa.sizeCelda), ((objeto.cuadColi.x + objeto.cuadColi.w)/mapa.sizeCelda) do
		for j=math.floor(objeto.cuadColi.y/mapa.sizeCelda), ((objeto.cuadColi.y + objeto.cuadColi.h)/mapa.sizeCelda) do
			mapa.matrizObjetos[math.floor(i)][math.floor(j)][objeto] = objeto
		end
	end
	local dir = mapa.objetos[math.floor(objeto.cuadColi.x/gfx:getWidth())][math.floor(objeto.cuadColi.y/gfx:getHeight())]
	dir[table.getn(dir)+1] = objeto

end

function mapa:eliminarObjeto( x, y )
	
	for f = 0, table.getn(mapa.objetos) do
		for j = 0,  table.getn(mapa.objetos[f]) do
			for i=table.getn(mapa.objetos[f][j]) , 1,-1 do
				local obj = mapa.objetos[f][j][i]
				if colision(obj.cuadColi, {x = x, y = y, w = 1, h = 1}) then
					for k = i, table.getn(mapa.objetos[f][j]) do
						mapa.objetos [f][j][k] = mapa.objetos[f][j][k+1]
						mapa.objetos [f][j][k+1] = nil
					end
					for i=math.floor(obj.cuadColi.x/mapa.sizeCelda), ((obj.cuadColi.x + obj.cuadColi.w)/mapa.sizeCelda) do
						for j=math.floor(obj.cuadColi.y/mapa.sizeCelda), ((obj.cuadColi.y + obj.cuadColi.h)/mapa.sizeCelda) do
							mapa.matrizObjetos[math.floor(i)][math.floor(j)][obj] = nil
						end
					end
					return
				end
			end
		end
	end
end

function mapa:colisiona( x, y, w, h )
	if x >= 0 and y >= 0 then
		for i = math.floor(x/mapa.sizeCelda), ((x+w)/mapa.sizeCelda) do
			for j = math.floor(y/mapa.sizeCelda), ((y+h)/mapa.sizeCelda)  do
				local q = {x = x, y = y, w = w, h = h}
				for k, v in pairs(mapa.matrizObjetos[math.floor(i)][math.floor(j)]) do
					if colision(q, v.cuadColi) then
						return true, v
					end
				end
			end	
		end
	end
	return false
end

function mapa:borrarMapa(  )
	mapa.matrizObjetos = {} 
	mapa.objetos = {}
	mapa:init()
end

function mapa:update()
	local wt = gfx.getWidth()
	local ht = gfx.getHeight()

	mapa.batch:bind()
    mapa.batch:clear()

    for i = math.floor(((mono.cuadColi.x - wt/2)/wt)-3), math.floor(((mono.cuadColi.x + wt/2)/wt)+3) do
    	if i>=0 then
    		for j = math.floor(((mono.cuadColi.y - ht/2)/ht)-3), math.floor(((mono.cuadColi.y + ht/2)/ht)+3) do
    			if j >=0 then
    				for a, v in pairs(mapa.objetos[i][j]) do
    					mapa.batch:addq(mapa.tipoTex[v.tipo], v.cuadColi.x - v.cuadColi.desX, v.cuadColi.y - v.cuadColi.desY)
    				end
				end
    		end
    	end
  	end
    mapa.batch:unbind()

end

function mapa:draw( )
	gfx.draw(mapa.batch, 0, 0)
end