Buff = Object:extend()

function Buff:new(tipo, valor, x, y)
    self.tipo = tipo
    self.valor = valor
    self.x = x * wScale + 700 * wScale
    self.y = y * wScale

    if self.tipo == "power" then
        self.image = love.graphics.newImage("artwork/gfx/UI/inGame/Pw-Sheet.png")
    elseif self.tipo == "speed" then
        self.image = love.graphics.newImage("artwork/gfx/UI/inGame/Sp-Sheet.png")
    elseif self.tipo == "fireRate" then
        self.image = love.graphics.newImage("artwork/gfx/UI/inGame/Fr-Sheet.png")
    end




    self.g = anim.newGrid(18,10,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-2',1), 0.1)

end

function Buff:update(dt)
    self.y = self.y + 100 * wScale * dt;
end

function Buff:draw()
    --[[love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, 10 * wScale, 10 * wScale)
    love.graphics.setColor(0, 0, 0)]]--
    self.idle:draw(self.image,self.x,self.y,0,3*wScale,3*wScale,0,5*wScale)
end
