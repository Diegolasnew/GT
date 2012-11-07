Caca = {}
Caca.__index = Caca
Caca.cuadColi =
	{
		x = 0,
		y = 0,
		w = 0,
		h = 0,
	}

function Caca:new(x, y, w, h)
	local aux = {}
	self.cuadColi.x = x
	self.cuadColi.y = y
	self.cuadColi.w = w
	self.cuadColi.h = h
	return setmetatable(aux, Caca)
end

function Caca:getNombre()
	return self.nombre
end
