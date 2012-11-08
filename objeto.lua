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
	obj.vx = 250
	obj.vy = 600
	obj.aceX = 100
	obj.aceY = 1600

	obj.vxReal = obj.vx
	obj.vyReal = obj.vy

	obj.tiempoSalto = 0.1
	obj.saltando = 0

	obj.estado = "normal"
	obj.lugar = "tierra"

	obj.sprite = new("spriteAnim")
	obj.tiempoSpt = 0.1
	obj.tiempoSptReal = 0

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
	local coliser = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y , obj.cuadColi.w, obj.cuadColi.h)

	if not coliser and (obj.estado == "normal" or obj.lugar == "tierra") then
		obj.estado = "cayendo"
		obj.lugar = "aire"
	end

	if obj.estado == "saltando" and obj.lugar == "aire" then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y - obj.vyReal*dt, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli and obj.saltando < obj.tiempoSalto then
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

	if love.keyboard.isDown("a") or love.keyboard.isDown("left") or coliser then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x - obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli or coliser then
			obj.cuadColi.x = obj.cuadColi.x - obj.vx*dt
			--obj.estado = "corriendo"
		end
	end

	if love.keyboard.isDown("d") or love.keyboard.isDown("right")then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x + obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli then
			obj.cuadColi.x = obj.cuadColi.x + obj.vx*dt
			--obj.estado = "corriendo"
		end
	end


	if obj.tiempoSptReal >= obj.tiempoSpt then
		obj.sprite:siguiente("corriendo")
		obj.tiempoSptReal = 0
	end

	obj.tiempoSptReal = obj.tiempoSptReal + dt
end




function obj:draw()
	gfx.draw(obj.sprite.batch, obj.cuadColi.x, obj.cuadColi.y, 0, 3, 3)
end

return obj