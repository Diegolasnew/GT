local ent = {}

ent.x = 0 -- posicion x de la entidad
ent.y = 0 -- posicion y de la entidad
ent.velX = 0 -- velocidad x de la entidad
ent.velY = 0 -- velocidad y de la entidad
ent.grad = 0 -- grado de rotacion de la entidad
ent.sprites = {} --sprites de la entidad (hashmap <string, imgSprite>)
ent.estados = {}
ent.estado = "normal"
ent.posSprite = 0
--posibles estados de la entidad
ent.estatico = true
ent.activo = true
ent.contolable = true
ent.tocable = true

function ent:update(dt) 
end

function ent:draw()
end

return ent