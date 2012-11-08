local spriteAnim = {}
	
	spriteAnim.tex = gfx.newImage("gfx/x1sheet.gif")
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
	spriteAnim.quads["corriendo"][1] = gfx.newQuad(106, 107, 30, 34, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][2] = gfx.newQuad(137, 107, 20, 34, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][3] = gfx.newQuad(158, 106, 23, 35, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][4] = gfx.newQuad(181, 107, 32, 34, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][5] = gfx.newQuad(213, 108, 34, 33, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][6] = gfx.newQuad(247, 108, 23, 33, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][7] = gfx.newQuad(276, 107, 22, 34, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][8] = gfx.newQuad(298, 106, 25, 35, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][9] = gfx.newQuad(326, 107, 30, 34, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][10] = gfx.newQuad(357, 108, 34, 33, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())
	spriteAnim.quads["corriendo"][11] = gfx.newQuad(391, 108, 29, 33, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())


end

function spriteAnim:siguiente(estado)
	if spriteAnim.estado ~= estado then
		spriteAnim.pos = 1
	end

	if spriteAnim.pos > table.getn(spriteAnim.quads[estado]) then
		spriteAnim.pos = 1
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