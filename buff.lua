Buff = Object:extend()

function Buff:new(tipo,ui)
    self.tipo = tipo
    self.width = 18*wScale
    self.height = 10*wScale
    self.x = love.math.random(187*wScale, love.graphics.getWidth()-self.width)
    self.y = 0
    self.ui = ui or false

    --Define qual tipo de imagem de buff vai usar
    if self.tipo == "power" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/Pw-Sheet.png") end
    if self.tipo == "speed" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/Sp-Sheet.png") end
    if self.tipo == "fRate" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/Fr-Sheet.png") end

    if self.tipo == "gPower" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/PwGold-Sheet.png") end
    if self.tipo == "gSpeed" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/SpGold-Sheet.png") end
    if self.tipo == "gFRate" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/FrGold-Sheet.png") end
    
    if self.tipo == "3x" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/3x-Sheet.png") end
    if self.tipo == "5x" then self.image = love.graphics.newImage("artwork/gfx/UI/inGame/5x-Sheet.png") end
    
    self.g = anim.newGrid(18,10,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-6',1), 0.08)

end

function Buff:update(dt)
    if self.ui == false then
        self.y = self.y + 50 * wScale * dt;
    end
    self.idle:update(dt)
end

function Buff:draw(x,y)
    if self.ui == false then
        self.idle:draw(self.image,self.x,self.y,0,1*wScale,1*wScale)
    end
    if self.ui == true then
        self.idle:draw(self.image,x,y,0,1*wScale,1*wScale)
    end

end
