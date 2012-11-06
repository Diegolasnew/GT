local obj = {}
	obj.cuadColi =
	{
		x = 0,
		y = 0,
		w = 0,
		h = 0,
	}
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
	obj.lugar = "tierra lpo	º"

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

	if love.keyboard.isDown("up") then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y - obj.vy*dt, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli then
			obj.cuadColi.y = obj.cuadColi.y - obj.vy*dt
		end
	end

	if love.keyboard.isDown("down") then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x, obj.cuadColi.y + obj.vy*dt, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli then
			obj.cuadColi.y = obj.cuadColi.y + obj.vy*dt
		end
	end
	if love.keyboard.isDown("left") or coliser then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x - obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli or coliser then
			obj.cuadColi.x = obj.cuadColi.x - obj.vx*dt
		end
	end
	if love.keyboard.isDown("right") then
		local coli, cuad = mapa:colisiona(obj.cuadColi.x + obj.vx*dt, obj.cuadColi.y, obj.cuadColi.w, obj.cuadColi.h)
		if  not coli then
			obj.cuadColi.x = obj.cuadColi.x + obj.vx*dt
		end
	end
end

return obj