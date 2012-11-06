local palo = {}
palo.x = 0
palo.y = 0
palo.ancho = 0
palo.alto = 0
palo.quad = 0

function palo:init(x, y, ancho, alto, quad)
	palo.x = x
	palo.y = y
	palo.ancho = ancho
	palo.alto = alto
	palo.quad = quad
end

return palo