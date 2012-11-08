local spriteAnim = {}
	
	spriteAnim.tex = gfx.newImage("gfx/mega2.png")
	spriteAnim.quads = {}
	spriteAnim.batch = gfx.newSpriteBatch(spriteAnim.tex, 2)

	spriteAnim.tiempo = 0
	spriteAnim.pos = 0
	spriteAnim.estado = "normal"

function spriteAnim:init(  )



	spriteAnim.quads["corriendo"] = {}
	spriteAnim.quads["saltando"] = {}
	spriteAnim.quads["cayendo"] = {}
	spriteAnim.quads["normal"] = {}

	print("inicializa")
	for i=0, (spriteAnim.tex:getWidth()/38)-1 do
		spriteAnim.quads["corriendo"][i] = gfx.newQuad(i*38, 0, 38, 35, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())	
	end

end

function spriteAnim:siguiente(estado)
	if spriteAnim.estado ~= estado then
		spriteAnim.pos = 0
	end

	if spriteAnim.pos > table.getn(spriteAnim.quads[estado]) then
		spriteAnim.pos = 0
	end

	spriteAnim.estado = estado

	local spr = spriteAnim.quads[estado][spriteAnim.pos]
	spriteAnim.pos = spriteAnim.pos + 1

	if spr then 
		spriteAnim.batch:bind()
		spriteAnim.batch:clear()

		spriteAnim.batch:addq(spr, 0, 0)

		spriteAnim.batch:unbind()
	end
end

return spriteAnim