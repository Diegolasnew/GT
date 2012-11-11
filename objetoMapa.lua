local obj = {}
obj.cuadColi =
	{
		x = 0,
		y = 0,
		w = 0,
		h = 0,
		desX = 0,
		desY = 0,
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


function obj:init(tipo, x, y, ancho, alto, desX, desY)

	obj.cuadColi.x = x
	obj.cuadColi.y = y
	obj.cuadColi.w = ancho
	obj.cuadColi.h = alto
	obj.tipo = tipo
	obj.cuadColi.desX = desX
	obj.cuadColi.desY = desY
end

return obj