Buff = Object:extend()

function Buff:new(tipo, valor, x, y)
    self.tipo = tipo
    self.valor = valor
    self.x = x * wScale + 700 * wScale
    self.y = y * wScale
end

function Buff:update(dt)
    self.y = self.y + 100 * wScale * dt;
end

function Buff:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, 10 * wScale, 10 * wScale)
    love.graphics.setColor(0, 0, 0)
end
