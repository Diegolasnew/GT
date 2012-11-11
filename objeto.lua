local obj = {}
obj.cuadColi =
	{
		x = 0,
		y = 0,
		w = 0,
		h = 0,
	}

	obj.minusX = 0
	obj.minusY = 0

	obj.tipo = 0
	obj.quad = 0
	obj.vx = 190
	obj.vy = 600
	obj.aceX = 100
	obj.aceY = 1600

	obj.vxReal = obj.vx
	obj.vyReal = 0

	obj.tiempoSalto = 0.1
	obj.saltando = 0

	obj.estado = "normal"
	obj.lugar = "tierra"

	obj.sprite = new("spriteAnim")
	obj.tiempoSpt = 0.1
	obj.tiempoSptReal = 0
	obj.orientacion = 1

	obj.fisica = true

function obj:init(x, y, ancho, alto, tipo, quad)
	print("ooo1")
	obj.sprite:init()
	print("ooo2")

	obj.cuadColi.x = x
	obj.cuadColi.y = y
	obj.cuadColi.w = ancho
	obj.cuadColi.h = alto
	obj.tipo = tipo
	obj.quad = quad
end

function obj:update( dt )
	if obj.fisica then
		local coliser = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y +4, obj.cuadColi.w, obj.cuadColi.h)
		local estado = obj.estado
		if not coliser and (obj.estado == "normal" or obj.lugar == "tierra") then
			obj.estado = "cayendo"
			obj.lugar = "aire"
		end

		if obj.estado == "saltando" and obj.lugar == "aire" then
			local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y - obj.vyReal*dt, obj.cuadColi.w, obj.cuadColi.h)
			if  not coli and obj.saltando <= obj.tiempoSalto then
				obj.cuadColi.y = obj.cuadColi.y - obj.vyReal*dt
				obj.saltando = obj.saltando + dt
			elseif not coli and obj.saltando > obj.tiempoSalto and obj.vyReal >= 0 then
				obj.cuadColi.y = obj.cuadColi.y - obj.vyReal*dt
				obj.vyReal = obj.vyReal - obj.aceY * dt
			else
				obj.estado = "cayendo"
				obj.saltando = 0
				obj.vyReal = 0
			end
		end


		if obj.estado == "cayendo" and obj.lugar == "aire" then
			local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y + obj.vyReal*dt, obj.cuadColi.w, obj.cuadColi.h)
			if  not coli then
					obj.cuadColi.y = obj.cuadColi.y + obj.vyReal*dt
					obj.vyReal = obj.vyReal + obj.aceY * dt
			else
				obj.cuadColi.y = cuad.cuadColi.y - obj.cuadColi.h - 1
				obj.lugar = "tierra"
				obj.estado = "normal"
				obj.vyReal = 0
			end
		end

		if love.keyboard.isDown(" ") and obj.lugar == "tierra" then
			obj.estado = "saltando"
			obj.lugar = "aire"
			obj.vyReal = obj.vy
		end

		if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
			local coli, cuad = mapa:colisiona(obj.cuadColi.x - obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
			if  not coli then
				obj.cuadColi.x = obj.cuadColi.x - obj.vx*dt
				obj.orientacion = -1
				if obj.lugar == "tierra" then
					obj.estado = "corriendo"
				end
			else
				if obj.lugar == "tierra" then
					obj.estado = "normal"
				end
			end

		end

		if love.keyboard.isDown("d") or love.keyboard.isDown("right")then
			local coli, cuad = mapa:colisiona(obj.cuadColi.x + obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
			if  not coli then
				obj.cuadColi.x = obj.cuadColi.x + obj.vx*dt
				obj.orientacion = 1
				if obj.lugar == "tierra" then
					obj.estado = "corriendo"
				end
			else
				if obj.lugar == "tierra" then
					obj.estado = "normal"
				end
			end
		end

		if obj.lugar == "tierra" and not love.keyboard.isDown("right") and not love.keyboard.isDown("left") 
			and not love.keyboard.isDown("a") and not love.keyboard.isDown("d") then
			obj.estado = "normal"
		end
		if estado ~= obj.estado then
			obj.tiempoSptReal = obj.tiempoSpt+1
		end

		
	else
		obj.estado = "normal"
		if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
			obj.cuadColi.x = obj.cuadColi.x - 300*dt
		end
		if love.keyboard.isDown("d") or love.keyboard.isDown("right")then
			obj.cuadColi.x = obj.cuadColi.x + 300*dt
		end
		if love.keyboard.isDown("w") or love.keyboard.isDown("up")  then
			obj.cuadColi.y = obj.cuadColi.y - 300*dt
		end
		if love.keyboard.isDown("s") or love.keyboard.isDown("down")  then
			obj.cuadColi.y = obj.cuadColi.y + 300*dt
		end
	end


	if obj.tiempoSptReal >= obj.tiempoSpt then
		obj.sprite:siguiente(obj.estado, obj.orientacion)
		obj.tiempoSptReal = 0
	end

	obj.tiempoSptReal = obj.tiempoSptReal + dt

	if obj.cuadColi.x < 0 then
		obj.cuadColi.x = 0
	end
	if obj.cuadColi.y < 0 then
		obj.cuadColi.y = 0
	end
end




function obj:draw()
	gfx.draw(obj.sprite.batchs[obj.sprite.estado], obj.cuadColi.x, obj.cuadColi.y)
end

return obj