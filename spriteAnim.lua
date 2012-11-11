local spriteAnim = {}
	
	spriteAnim.tex = gfx.newImage("gfx/mega.png")	
	spriteAnim.tex2 = gfx.newImage("gfx/megaSal.png")
	spriteAnim.tex3 = gfx.newImage("gfx/megaCai.png")
	spriteAnim.tex4 = gfx.newImage("gfx/megaNOr.png")

	spriteAnim.quads = {}
	spriteAnim.batchs = {}
	--spriteAnim.batch = gfx.newSpriteBatch(spriteAnim.tex, 2)


	spriteAnim.tiempo = 0
	spriteAnim.pos = 0
	spriteAnim.estado = "normal"

function spriteAnim:init(  )

	spriteAnim.quads["corriendo"] = {}
	spriteAnim.quads["saltando"] = {}
	spriteAnim.quads["cayendo"] = {}
	spriteAnim.quads["normal"] = {}

	spriteAnim.batchs["corriendo"] = gfx.newSpriteBatch(spriteAnim.tex, 2)
	spriteAnim.batchs["saltando"] = gfx.newSpriteBatch(spriteAnim.tex2, 2)
	spriteAnim.batchs["cayendo"] = gfx.newSpriteBatch(spriteAnim.tex3, 2)
	spriteAnim.batchs["normal"] = gfx.newSpriteBatch(spriteAnim.tex4, 2)

	print("inicializa")
	for i=0, 9 do
		spriteAnim.quads["corriendo"][i] = gfx.newQuad(i*38, 0, 38, 35, spriteAnim.tex:getWidth(), spriteAnim.tex:getHeight())	
	end
	spriteAnim.quads["saltando"][0] = gfx.newQuad(0, 0, 19, 46, spriteAnim.tex2:getWidth(), spriteAnim.tex2:getHeight())	
	spriteAnim.quads["cayendo"][0] = gfx.newQuad(0, 0, 23, 41, spriteAnim.tex3:getWidth(), spriteAnim.tex3:getHeight())	
	spriteAnim.quads["normal"][0] = gfx.newQuad(0, 0, 30, 34, spriteAnim.tex4:getWidth(), spriteAnim.tex4:getHeight())	

end

function spriteAnim:siguiente(estado, ori)
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
		--print("pasa")
		spriteAnim.batchs[estado]:bind()
		spriteAnim.batchs[estado]:clear()
		if ori == -1 then
			x, y, w, h = spr:getViewport( )
			spriteAnim.batchs[estado]:addq(spr, w, 0, 0, ori, 1)
		else
			spriteAnim.batchs[estado]:addq(spr, 0, 0, 0, ori, 1)
		end
		spriteAnim.batchs[estado]:unbind()
	end

end

return spriteAnim