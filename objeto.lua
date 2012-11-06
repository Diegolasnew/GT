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
	obj.vy = 250
	obj.aceX = 100
	obj.aceY = 100

	obj.vxReal = obj.vx
	obj.vyReal = obj.vy

	obj.tiempoSalto = 1
	obj.saltando = 0

	obj.estado = "normal"
	obj.lugar = "tierra"

function obj:init(x, y, ancho, alto, tipo, quad)
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
		local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y - obj.vy*dt, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli and obj.saltando < obj.tiempoSalto then
			obj.cuadColi.y = obj.cuadColi.y - obj.vy*dt
			obj.saltando = obj.saltando + dt
		--elseif not coli and obj.saltando > obj.tiempoSalto

		else
			obj.estado = "cayendo"
			obj.saltando = 0
		end
	end


	if obj.estado == "cayendo" and obj.lugar == "aire" then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y + obj.vy*dt, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli then
			obj.cuadColi.y = obj.cuadColi.y + obj.vy*dt
		else
			obj.lugar = "tierra"
			obj.estado = "normal"
		end
	end

	if love.keyboard.isDown(" ") and obj.lugar == "tierra" then
		obj.estado = "saltando"
		obj.lugar = "aire"
	end

	if love.keyboard.isDown("a") or coliser then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x - obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli or coliser then
			obj.cuadColi.x = obj.cuadColi.x - obj.vx*dt
		end
	end
	if love.keyboard.isDown("d") then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x + obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli then
			obj.cuadColi.x = obj.cuadColi.x + obj.vx*dt
		end
	end
end

return obj